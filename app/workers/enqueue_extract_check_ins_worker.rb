class EnqueueExtractCheckInsWorker
  include Sidekiq::Worker

  sidekiq_options queue: "high"

  def perform
    User.to_import.find_each do |user|
      Import.create!(user: user)
    end
  end
end
