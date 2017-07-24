class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :weeks, through: :goals

  enum role: %w(default admin)

  validates :github_id, presence: true
  validates :phone_number, presence: true, if: :wants_reminder?

  scope :text_recipients, -> { where(wants_reminder: true) }


  def sanitize_phone_number
    phone_number.gsub(/-/, '').prepend("+1")
  end

end
