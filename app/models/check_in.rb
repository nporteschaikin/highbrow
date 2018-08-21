class CheckIn < ApplicationRecord
  upsert_keys %w[external_id]

  belongs_to :user
  belongs_to :venue, optional: true
end
