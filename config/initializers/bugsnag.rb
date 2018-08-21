Bugsnag.configure do |config|
  if (api_key = ENV["BUGSNAG_API_KEY"]).present?
    config.api_key = api_key
  end
end
