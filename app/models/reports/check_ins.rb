module Reports
  class CheckIns < Report
    include Rails.application.routes.url_helpers

    def scatter_query_path
      query_path(Queries::CheckInScatter.path, args)
    end
  end
end
