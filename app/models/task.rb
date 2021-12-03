class Task < ApplicationRecord
  belongs_to :project
  has_many :assignments
  attr_accessor :attr

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
