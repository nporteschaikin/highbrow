class Import < ApplicationRecord
  belongs_to :user
  has_many :import_check_ins
  has_many :check_ins, through: :import_check_ins

  after_create :enqueue

  NEW       = "new".freeze
  IMPORTING = "importing".freeze
  DONE      = "done".freeze
  ERRORED   = "errored".freeze

  attribute :status, default: NEW
  delegate :token, to: :user

  private

  def enqueue
    ExtractCheckInsWorker.perform_async(id)
  end
end
