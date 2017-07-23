class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :weeks, through: :goals

  enum role: %w(default admin)
  enum wants_reminder: %w(0 1)

  validates :github_id, presence: true

  scope :text_recipients, -> { where(wants_reminder?: true) }

end
