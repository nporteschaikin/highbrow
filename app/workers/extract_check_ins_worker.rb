class ExtractCheckInsWorker
  include Sidekiq::Worker

  sidekiq_options queue: "high"

  LIMIT = 250

  def perform(id, args = {})
    offset    = args.fetch("offset", 0)
    limit     = args.fetch("limit", LIMIT)

    import    = Import.find(id)
    import.update!(status: Import::IMPORTING)

    client    = Foursquare::Client.new(import.token)
    body      = client.get("users/self/checkins", args.merge("offset" => offset, "limit" => limit)).body

    checkins  = body.fetch("response").fetch("checkins")
    nodes     = checkins.fetch("items")
    count     = checkins.fetch("count")

    nodes.each do |node|
      handle_check_in(import, node)
    end

    if count > (offset + limit)
      self.class.perform_async(id, args.merge("offset" => offset + limit, "limit" => limit))
    else
      # TODO: Improve this by making it one query.
      import.user.check_ins.where.not(id: import.check_ins.pluck(:id)).delete_all

      import.update!(status: Import::DONE, finished_at: Time.now)
    end
  rescue => ex
    handle_exception(import, ex)
  end

  private

  def handle_check_in(import, node)
    attributes = Foursquare::Adapters::CheckInAdapter.new(node).attributes.merge(
      user_id:  import.user.id,
      venue_id: (handle_venue(node.fetch("venue")).id if node["venue"].present?),
    )

    CheckIn.upsert!(attributes).tap do |check_in|
      ImportCheckIn.upsert!(import_id: import.id, check_in_id: check_in.id)

      node.fetch("with", []).each do |with|
        handle_check_in_tagged_user(check_in, with)
      end
    end
  end

  def handle_check_in_tagged_user(check_in, node)
    CheckInTaggedUser.upsert!(
      Foursquare::Adapters::CheckInTaggedUserAdapter.new(node).attributes.merge(
        check_in_id:  check_in.id,
        user_id:      handle_user(node).id,
      ),
    )
  end

  def handle_venue(node)
    attributes = Foursquare::Adapters::VenueAdapter.new(node).attributes

    Venue.upsert!(attributes).tap do |venue|
      venue.enqueue_rating_sync! if venue.sync_rating?
    end
  end

  def handle_user(node)
    User.upsert!(
      Foursquare::Adapters::UserAdapter.new(node).attributes,
    )
  end

  def handle_exception(import, ex)
    import.update!(status: Import::ERRORED)

    raise ex
  end
end
