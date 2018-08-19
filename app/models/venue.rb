class Venue < ApplicationRecord
  upsert_keys %w[external_id]

  has_many :check_ins

  scope :to_sync_rating, -> { where(rating_sync_status: [NEW, DONE, ERRORED]).
                              where("rating_last_synced_at is null or rating_last_synced_at < ?", 1.month.ago).
                              limit(4_500) }

  NEW     = "new".freeze
  PENDING = "pending".freeze
  SYNCING = "syncing".freeze
  DONE    = "done".freeze
  ERRORED = "errored".freeze

  attribute :rating_sync_status, default: NEW
end
