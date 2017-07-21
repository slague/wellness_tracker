class User::GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :destroy]
  before_action :set_user, only: [:create, :update, :increment]

  def index
    @goals = current_user.goals.where(week_id: current_week.id)
  end

  def show
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def create
    @goal = current_user.goals.new(goal_params)
    new_total = goal_params[:total_goal_count]

    # if @goal.reasonable_total?(new_total) && @goal.save
    if @goal.save && new_total.to_i <= 7
      flash[:success] = "Goal was successfully created."
      redirect_to user_goals_path(current_user)
    else
      flash.now[:danger] = "You cannot have more than seven #{@goal.category.name} goals!"
      render :new
    end
  end

  def update
    # require "pry"; binding.pry
    @goal = current_user.goals.find(params[:format])
    @goal.update(goal_params)
    new_total = goal_params[:total_goal_count]

    # if @goal.reasonable_total?(new_total) && @goal.update(goal_params)
    if new_total.to_i <= 7 && @goal.save
      flash.now[:success] = 'Goal was successfully updated.'
      redirect_to user_goals_path
    elsif
      flash.now[:danger] = "You cannot have more than seven #{@goal.category.name} goals!"
      render :edit
    else
      render :edit
    end
  end

  def increment
    @goal = @user.goals.find(params[:id])
    new_count = @goal.progress_count + 1

    if @goal.update(progress_count: new_count) && (@goal.total_goal_count == new_count)
      flash.now[:success] = 'You achieved your goal for the week. Awesome!'
      redirect_to user_goals_path
    elsif @goal.update(progress_count: new_count)
      flash.now[:success] = 'Nicely done!'
      redirect_to user_goals_path
    else
      flash.now[:danger] = 'Unable to increment goal.'
      redirect_to user_goals_path
    end

  end

  def destroy
    @goal.destroy
    flash.now[:success] = "Goal Successfully Deleted!"
    redirect_to user_goals_path
  end

  private
    def set_user
      @user = current_user
    end

    def set_goal
      # require "pry"; binding.pry
      @goal = current_user.goals.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:description,
                                   :total_goal_count,
                                   :category_id).merge(week: current_week)
    end
end
