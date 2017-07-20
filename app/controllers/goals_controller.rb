class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:create, :update, :increment]

  def index
    @goals = current_user.goals.where(week_id: current_week.id)
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def create
    @goal = @user.goals.new(goal_params)
    new_total = goal_params[:total_goal_count]

    if @goal.reasonable_total?(new_total) && @goal.save  
      flash[:success] = "Goal was successfully created."
      redirect_to user_goals_path(@user)
    elsif
      flash[:danger] = "You cannot have more than seven #{@goal.category.name} goals!"
      render :new
    else
      render :new
    end
  end

  def update
    @goal = @user.goals.find(params[:id])
    @goal.update(goal_params)
    new_total = goal_params[:total_goal_count]

    # if @goal.reasonable_total?(new_total) && @goal.update(goal_params)
    if new_total.to_i <= 7 && @goal.save
      flash[:success] = 'Goal was successfully updated.'
      redirect_to user_goals_path(@user)
    elsif
      flash[:danger] = "You cannot have more than seven #{@goal.category.name} goals!"
      render :edit
    else
      render :edit
    end
  end

  def increment
    @goal = @user.goals.find(params[:id])
    new_count = @goal.progress_count + 1

    if @goal.update(progress_count: new_count) && (@goal.total_goal_count == new_count)
      flash[:success] = 'You achieved your goal for the week. Awesome!'
      redirect_to user_goals_path(@user)
    elsif @goal.update(progress_count: new_count)
      flash[:success] = 'Nicely done!'
      redirect_to user_goals_path(@user)
    else
      flash[:danger] = 'Unable to increment goal.'
      redirect_to user_goals_path(@user)
    end

  end

  def destroy
    @goal.destroy
    flash[:success] = "Goal Successfully Deleted!"
    redirect_to user_goals_path
  end

  private
    def set_user
      @user = current_user
    end

    def set_goal
      @goal = Goal.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:description,
                                   :total_goal_count,
                                   :category_id).merge(week: current_week)
    end
end
