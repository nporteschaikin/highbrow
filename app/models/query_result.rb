class QueryResult
  include Enumerable

  def initialize(definition, user, args = {})
    @definition = definition
    @user = user
    @args = args
  end

  def each
    result.each do |row|
      yield attributes_builder.build_from_database(row).to_h
    end
  end

  private

  attr_reader :definition, :user, :args

  def attributes_builder
    @attributes_builder ||= ActiveRecord::AttributeSet::Builder.new(result.column_types.dup)
  end

  def result
    @result ||= ActiveRecord::Base.connection.select_all(
      ActiveRecord::Base.send(:sanitize_sql_array, [definition.sql, args.merge(user_id: user.id)]),
    )
  end
end
