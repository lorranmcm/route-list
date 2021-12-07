class User < ApplicationRecord
  has_many :assignments
  has_many :projects
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: %I[first_name last_name],
                  using: {
                    tsearch: { prefix: true }
                  }
end
