class ExtractVenueRatingsWorker
  include Sidekiq::Worker

  def perform
    Venue.to_sync_rating.find_each do |venue|
      venue.update!(rating_sync_status: Venue::PENDING)

      ExtractVenueRatingWorker.perform_async(venue.id)
    end
  end
end
