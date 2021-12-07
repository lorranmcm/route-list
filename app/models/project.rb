class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title,
                  against: :title,
                  using: {
                    tsearch: { prefix: true }
                  }
end
