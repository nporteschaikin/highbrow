class Query
  class Row
    def initialize(attributes = {})
      @attributes = attributes
    end

    def method_missing(name, *)
      if attributes.key?(name.to_s)
        attributes.fetch(name.to_s)
      else
        super
      end
    end

    private

    attr_reader :attributes
  end

  include Enumerable

  def initialize(sql, args = {})
    @sql = sql
    @args = args
  end

  def each(&block)
    result.each do |attributes|
      block.call(Row.new(attributes))
    end
  end

  private

  attr_reader :sql, :args

  def result
    @result ||= ActiveRecord::Base.connection.select_all(
      ActiveRecord::Base.send(:sanitize_sql_array, [sql, args]),
    )
  end
end
