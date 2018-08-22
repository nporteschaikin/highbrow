module Reports
  class YourRating < Report
    def chart
      @chart ||= Charts::Rating.new(user)
    end
  end
end
