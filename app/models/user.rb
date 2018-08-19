class User < ApplicationRecord
  upsert_keys %w[external_id]

  def self.upsert_from_token(token)
    client = Foursquare::Client.new(token)
    response = client.get("users/self")
    attributes = Foursquare::Adapters::UserAdapter.new(response.body.fetch("response").fetch("user")).attributes

    upsert(attributes.merge(token: token)).tap do |user|
      CheckInSync.create!(user_id: user.id)
    end
  end
end
