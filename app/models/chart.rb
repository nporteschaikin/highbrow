class Chart
  include Rails.application.routes.url_helpers

  def self.slug
    name.demodulize.underscore.dasherize
  end

  def initialize(user, params = {})
    @user = user
    @params = params
  end

  def to_json
    {}
  end

  def json_path
    chart_path(self.class.slug)
  end

  def to_partial_path
    "charts/chart"
  end

  protected

  attr_reader :user, :params
end
