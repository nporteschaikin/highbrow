class ExtractVenueRatingWorker
  include Sidekiq::Worker

  def perform(id)
    venue   = Venue.find(id)
    venue.update!(rating_sync_status: Venue::SYNCING)

    venue.update!(
      rating:                Foursquare::RatingFinder.new(venue).find,
      rating_sync_status:    Venue::DONE,
      rating_last_synced_at: Time.now,
    )
  rescue => ex
    venue.update!(rating_sync_status: Venue::ERRORED) if venue.present?

    raise ex
  end
end
