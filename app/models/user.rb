class User < ApplicationRecord
  has_many :assignments
  has_many :projects

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: %I[first_name last_name],
                  using: {
                    tsearch: { prefix: true }
                  }
  def full_name
    "#{first_name} #{last_name}"
  end
end
