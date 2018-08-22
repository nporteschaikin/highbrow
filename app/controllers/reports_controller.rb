class ReportsController < ApplicationController
  before_action :redirect_if_logged_out

  ReportNotValid = Class.new(StandardError)

  VALID_REPORTS = %w[
    your-rating
  ]

  def show
    raise ReportNotValid unless VALID_REPORTS.include?(params.fetch(:id))

    @report = ("Reports::%s" % params.fetch(:id).underscore.camelize).constantize.new(
      current_user,
    )
  end
end
