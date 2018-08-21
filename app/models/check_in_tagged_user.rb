class CheckInTaggedUser < ApplicationRecord
  upsert_keys %w[check_in_id user_id]
end
