class User < ApplicationRecord
  has_many :goals
  has_many :weeks, through: :goals

  # enum role: %w(standard admin)
end
