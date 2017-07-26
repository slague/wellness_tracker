class Goal < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :week

  validates :description, :category_id, :user_id, :week_id, :total_goal_count, presence: true


  def self.community_progress(week_id, category_id)
      where(week_id: week_id).where(category_id: category_id).map { |goal| goal.progress_count }.reduce(:+)
  end

  def self.community_total(week_id, category_id)
    where(week_id: week_id).where(category_id: category_id).map { |goal| goal.total_goal_count }.reduce(:+)
  end

  def achieved?
    total_goal_count == progress_count
  end

end

# <><><>If Goals become restricted to ONLY 7 TOTAL per category, use these methods<><><>

# def all_category_totals
#   user.goals.where(category: category).pluck(:total_goal_count)
# end
# #
# def category_total
#   all_category_totals.reduce(:+)
# end
#
# def reasonable_total?(new_total)
#   if all_category_totals.empty?
#     new_total.to_i <= 7
#   else
#     pre_update_total = category_total - total_goal_count
#     post_update_total = pre_update_total + new_total.to_i
#
#     post_update_total <= 7
#   end
# end
