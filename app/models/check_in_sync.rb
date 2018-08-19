class CheckInSync < ApplicationRecord
  belongs_to :user
  has_many :check_ins

  after_create :enqueue

  NEW     = "new".freeze
  SYNCING = "syncing".freeze
  DONE    = "done".freeze
  ERRORED = "errored".freeze

  attribute :status, default: NEW
  delegate :token, to: :user

  private

  def enqueue
    ExtractCheckInsWorker.perform_async(id)
  end
end
