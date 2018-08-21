class Venue < ApplicationRecord
  RATING_TTL = 1.month

  upsert_keys %w[external_id]

  has_many :check_ins

  scope :to_sync_rating, -> {
    where(rating_sync_status: [NEW, DONE, ERRORED]).
    where("rating_last_synced_at is null or rating_last_synced_at < ?", RATING_TTL.ago).
    limit(4_500)
  }

  NEW     = "new".freeze
  PENDING = "pending".freeze
  SYNCING = "syncing".freeze
  DONE    = "done".freeze
  ERRORED = "errored".freeze

  attribute :rating_sync_status, default: NEW

  def enqueue_rating_sync!
    update!(rating_sync_status: PENDING).tap do
      ExtractVenueRatingWorker.perform_async(id)
    end
  end

  def sync_rating?
    [NEW, DONE, ERRORED].include?(rating_sync_status) &&
      (rating_last_synced_at.nil? || rating_last_synced_at < RATING_TTL.ago)
  end
end
