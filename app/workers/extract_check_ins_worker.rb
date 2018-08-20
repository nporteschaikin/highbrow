class ExtractCheckInsWorker
  include Sidekiq::Worker

  LIMIT = 250

  def perform(id, args = {})
    offset    = args.fetch("offset", 0)
    limit     = args.fetch("limit", LIMIT)

    sync      = CheckInSync.find(id)
    sync.update!(status: CheckInSync::SYNCING)

    client    = Foursquare::Client.new(sync.token)
    body      = client.get("users/self/checkins", args.merge("offset" => offset, "limit" => limit)).body

    checkins  = body.fetch("response").fetch("checkins")
    nodes     = checkins.fetch("items")
    count     = checkins.fetch("count")

    nodes.each do |node|
      handle_check_in(sync, node)
    end

    if count > (offset + limit)
      self.class.perform_async(id, args.merge("offset" => offset + limit, "limit" => limit))
    else
      sync.update!(status: CheckInSync::DONE)
    end
  rescue => ex
    handle_exception(sync, ex)
  end

  private

  def handle_check_in(sync, node)
    attributes = Foursquare::Adapters::CheckInAdapter.new(node).attributes.merge(
      check_in_sync_id:   sync.id,
      venue_id:           (handle_venue(node.fetch("venue")).id if node["venue"].present?)
    )

    CheckIn.upsert(attributes).tap do |check_in|
      node.fetch("with", []).each do |with|
        handle_check_in_user(check_in, with)
      end
    end
  end

  def handle_check_in_user(check_in, node)
    CheckInUser.upsert(
      Foursquare::Adapters::CheckInUserAdapter.new(node).attributes.merge(
        check_in_id:  check_in.id,
        user_id:      handle_user(node).id,
      ),
    )
  end

  def handle_venue(node)
    Venue.upsert(
      Foursquare::Adapters::VenueAdapter.new(node).attributes,
    )
  end

  def handle_user(node)
    User.upsert(
      Foursquare::Adapters::UserAdapter.new(node).attributes,
    )
  end

  def handle_exception(sync, ex)
    sync.update!(status: CheckInSync::ERRORED)

    raise ex
  end
end
