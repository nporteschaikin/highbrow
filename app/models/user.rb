class User < ApplicationRecord
  upsert_keys %w[external_id]

  has_many :imports

  # Only periodically import check-ins for users that:
  # - have no imports created in the last six hours, and
  # - have at least one import.
  scope :to_import, -> {
    joins("left outer join imports a on a.user_id = users.id and a.created_at > now() - interval '6 hours'").
    joins("left outer join imports b on b.user_id = users.id").
    where("token is not null and a.id is null and b.id is not null")
  }

  def self.upsert_from_token(token)
    client = Foursquare::Client.new(token)
    response = client.get("users/self")
    attributes = Foursquare::Adapters::UserAdapter.new(response.body.fetch("response").fetch("user")).attributes

    upsert(attributes.merge(token: token)).tap do |user|
      Import.create!(user_id: user.id) if user.imports.none?
    end
  end
end
