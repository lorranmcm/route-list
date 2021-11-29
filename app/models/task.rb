class Task < ApplicationRecord
  belongs_to :task_group
  has_many :users
end
