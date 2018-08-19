class HomeController < ApplicationController
  before_action :redirect_if_logged_out

  def show; end
end
