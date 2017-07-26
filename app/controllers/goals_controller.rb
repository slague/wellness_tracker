class GoalsController < ApplicationController

  def index
    @categories = Category.all
  end

  def increment
    @goal = current_user.goals.find(params[:id])
    new_count = @goal.progress_count + 1

    if @goal.update(progress_count: new_count)
      render json: {progress_count: @goal.progress_count, total_goal_count: @goal.total_goal_count}.to_json
    else
      flash.now[:danger] = 'Unable to increment goal.'
      redirect_to user_goals_path
    end
  end

end
