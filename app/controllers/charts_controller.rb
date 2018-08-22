class ChartsController < ApplicationController
  before_action :redirect_if_logged_out

  ChartNotValid = Class.new(StandardError)

  VALID_CHARTS = %w[
    rating
  ]

  def show
    raise ChartNotValid unless VALID_CHARTS.include?(params.fetch(:id))

    chart = ("Charts::%s" % params.fetch(:id).classify).constantize.new(
      current_user,
      chart_params.to_h,
    )

    render json: chart.to_json
  end

  private

  def chart_params
    params.permit!(
      # idk
    )
  end
end
