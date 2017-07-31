class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :weeks, through: :goals
  has_many :winners

  enum role: %w(default admin)

  validates :github_id, presence: true
  validates :phone_number, presence: true, if: :wants_reminder?

  scope :text_recipients, -> { where(wants_reminder: true) }

  after_update :send_confirmation_message, if: -> { self.wants_reminder? && (wants_reminder_changed? || phone_number_changed?) }


  def send_confirmation_message
    Reminder.send_confirmation_message(self)
  end
  def sanitize_phone_number
    phone_number.gsub(/-/, '').prepend("+1")
  end

  def weekly_progress(week_id)
     goals.where(week_id: week_id).map {|goal| goal.progress_count }.reduce(:+)
  end
  def weekly_total_achieved(week_id)
     goals.where(week_id: week_id).map {|goal| goal.total_goal_count }.reduce(:+)
  end

  def achieved_all_goals_this_week?(week_id)
    goals.where(week_id: week_id).count > 0 && weekly_progress(week_id) == weekly_total_achieved(week_id)
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
    random_winner = User.achievers(week_id).shuffle.pop
    Winner.create(user_id: random_winner.id, week_id: week_id)
  end

  def self.mod_winners(mod_id)
    # mod winners are students who achieve 100% of goals every week
    # make an array achievers for each week
      # array_week_1 = [student, student2, student5]
      # array_week_2 = [student, student2, student5, student7]
      # array_week_3 = [student, student2, student4]
      # array_week_4 = [student, student2, student6]
      # array_week_5 = [student, student2, student5]
      # array_week_6 = [student, student2, student5, student6, student7]

      # take the names that appear in each array: student and student2 are mod winners

    current_mod = Mod.find(mod_id)
    current_mod.weeks.each do |week|
      # make an array = User.achievers(week.id)
    end
# filter out
  end

end
