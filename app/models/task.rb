class Task < ApplicationRecord
  belongs_to :project
  has_many :assignments
  attr_accessor :attr
end
