class QueryResult
  include Enumerable

  def initialize(definition, user, args = {})
    @definition = definition
    @user = user
    @args = args
  end

  delegate :each, to: :result

  private

  attr_reader :definition, :user, :args

  def result
    @result ||= ActiveRecord::Base.connection.select_all(
      ActiveRecord::Base.send(:sanitize_sql_array, [definition.sql, args.merge(user_id: user.id)]),
    )
  end
end
