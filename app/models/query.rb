class Query < Module
  attr_reader :sql

  def initialize(sql)
    @sql = sql
  end

  def path
    name.demodulize.underscore.dasherize
  end
end
