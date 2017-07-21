class GoalsController < ApplicationController

  def index
    @sweat = Category.find(1)
    @sleep = Category.find(2)
    @personal = Category.find(3)
    @nutrition = Category.find(4)
    
    @sweat_progress = Goal.community_progress(current_week.id, 1)
    @sleep_progress = Goal.community_progress(current_week.id, 2)
    @personal_progress = Goal.community_progress(current_week.id, 3)
    @nutrition_progress = Goal.community_progress(current_week.id, 4)

    @sweat_total = Goal.community_total(current_week.id, 1)
    @sleep_total = Goal.community_total(current_week.id, 2)
    @personal_total = Goal.community_total(current_week.id, 3)
    @nutrition_total = Goal.community_total(current_week.id, 4)
  end

end
