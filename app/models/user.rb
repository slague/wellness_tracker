class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :weeks, through: :goals

  enum role: %w(default admin)

end
