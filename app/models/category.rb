class Category < ApplicationRecord
  upsert_keys %w[external_id]
end
