module Reports
  class Venues < Report
    include Rails.application.routes.url_helpers

    def scatter_query_path
      query_path(Queries::VenuesScatter.path, args)
    end

    def categories_query_path
      query_path(Queries::TopVenueCategories.path, args)
    end
  end
end
