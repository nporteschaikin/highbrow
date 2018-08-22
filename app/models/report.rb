class Report
  def self.slug
    name.demodulize.underscore
  end

  def initialize(user)
    @user = user
  end

  def to_partial_path
    "reports/%s" % self.class.slug
  end

  protected

  attr_reader :user, :params
end
