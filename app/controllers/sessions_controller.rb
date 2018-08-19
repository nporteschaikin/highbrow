class SessionsController < ApplicationController
  before_action :redirect_if_logged_in

  def new
    @oauth = Foursquare::OauthClient.new
  end

  def callback
    oauth = Foursquare::OauthClient.new
    access_token = oauth.auth_code.get_token(
      params.fetch(:code),
      redirect_uri: sessions_callback_url,
    )

    self.current_user = User.upsert_from_token(access_token.token)
    redirect_to root_path
  end
end
