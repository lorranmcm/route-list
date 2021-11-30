class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, :order => 'order ASC'
end
