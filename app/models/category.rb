class Category < ApplicationRecord
  has_many :goals
  validates :name, presence: true

  def get_community_progress(week_id)
    goals.where(week_id: week_id).map {|x| x.progress_count}.reduce(:+)
  end
  def get_community_total_count(week_id)
    goals.where(week_id: week_id).map {|x| x.total_goal_count}.reduce(:+)
  end

end
