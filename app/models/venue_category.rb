class VenueCategory < ApplicationRecord
  upsert_keys %w[venue_id category_id]
end
