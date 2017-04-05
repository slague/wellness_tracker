class Goal < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :week

  validates :description, :category_id, :user_id, :week_id, :total_goal_count, presence: true 
end
