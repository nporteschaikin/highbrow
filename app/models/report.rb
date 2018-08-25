class Report
  def initialize(user, args = {})
    @user = user
    @args = args
  end

  def to_partial_path
    "reports/%s" % self.class.name.demodulize.underscore
  end

  protected

  attr_reader :user, :args
end
