class ImportCheckIn < ApplicationRecord
  belongs_to :import
  belongs_to :check_in
end
