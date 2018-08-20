class ExtractVenueRatingsWorker
  include Sidekiq::Worker

  sidekiq_options queue: "low"

  def perform
    Venue.to_sync_rating.find_each do |venue|
      venue.enqueue_rating_sync!
    end
  end
end
