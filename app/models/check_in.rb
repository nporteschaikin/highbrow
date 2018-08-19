class CheckIn < ApplicationRecord
  upsert_keys %w[check_in_sync_id external_id]

  belongs_to :check_in_sync
  belongs_to :venue
end
