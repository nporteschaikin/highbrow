class QueriesController < ApplicationController
  before_action :redirect_if_logged_out

  QueryNotFound = Class.new(StandardError)

  VALID_QUERIES = %w[
    check-in-scatter
  ]

  def show
    raise QueryNotFound unless VALID_QUERIES.include?(params.fetch(:id))

    render json: QueryResult.new(
      ("Queries::%s" % params.fetch(:id).underscore.classify).constantize,
      current_user,
      query_params.to_h,
    )
  end

  private

  def query_params
    params.permit!(
      # idk
    )
  end
end
