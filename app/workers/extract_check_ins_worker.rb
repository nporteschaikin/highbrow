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
      handle_node(sync, node)
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

  def handle_node(sync, node)
    venue = Venue.upsert(
      Foursquare::Adapters::VenueAdapter.new(node.fetch("venue")).attributes,
    )

    CheckIn.upsert(
      Foursquare::Adapters::CheckInAdapter.new(node).attributes.merge(
        check_in_sync_id:   sync.id,
        venue_id:           venue.id,
      ),
    )
  end

  def handle_exception(sync, ex)
    sync.update!(status: CheckInSync::ERRORED)

    raise ex
  end
end
