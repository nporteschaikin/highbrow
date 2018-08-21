require "clockwork"
require "./config/environment"
require "./config/boot"

module Clockwork
  handler do |job|
    job.perform_async
  end

  every(1.minute, EnqueueExtractCheckInsWorker)
  every(12.hours, EnqueueExtractVenueRatingWorker)
end
