class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :weeks, through: :goals

  enum role: %w(default admin)

  validates :github_id, presence: true
  validates :phone_number, presence: true, if: :wants_reminder?

  scope :text_recipients, -> { where(wants_reminder: true) }

  after_update :send_confirmation_message, if: -> { self.wants_reminder? && (wants_reminder_changed? || phone_number_changed?) }


  def send_confirmation_message
    Reminder.send_confirmation_message(self)
    # Call the method in Reminder class, passing in the user we want notified
  end
  def sanitize_phone_number
    phone_number.gsub(/-/, '').prepend("+1")
  end

  def personal_weekly_progress(week_id)
     goals.where(week_id: week_id).map {|goal| goal.progress_count }.reduce(:+)
  end
  def personal_weekly_total_achieved(week_id)
     goals.where(week_id: week_id).map {|goal| goal.total_goal_count }.reduce(:+)
  end

  def achieved_all_goals_this_week?(week_id)
   personal_weekly_progress(week_id) == personal_weekly_total_achieved(week_id)
  end

  def self.achievers(week_id)
    achievers = []
    all.each do |x|
      if x.achieved_all_goals_this_week?(week_id)
        achievers << x
      end
    end
   achievers
  end

  def self.select_weekly_winner(week_id)
    winner = User.achievers(week_id).shuffle.pop
    # don't want this to change every time it is run... run once and save the user as that week's winner

    # week = current_week
    # winner.id == week.winner_id
  end
end
