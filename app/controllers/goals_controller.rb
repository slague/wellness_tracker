class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    # @user = User.find(params[:user_id])
    # @goal = @user.goals.find(params[:id])
  end

  # GET /goals/new
  def new
    @user = User.find(params[:user_id])
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
    @user = User.find(params[:user_id])
    @goal = @user.goals.find(params[:id])
  end

  # POST /goals
  # POST /goals.json
  def create
    @user = User.find(params[:user_id])
    @goal = @user.goals.new(goal_params.merge(week: current_week))

    if @goal.save
      flash[:success] = "Goal was successfully created."
      redirect_to user_goals_path(@user)
    else
      render :new
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update

    @user = User.find(params[:user_id])

    if @user.goals.update(goal_params.merge(week: current_week))
      flash[:success] = 'Goal was successfully updated.'
      redirect_to user_goals_path(@user)
    else
      render :edit
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    flash[:success] = "Goal Successfully Deleted!"
      redirect_to user_goals_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:description, :progress_count, :total_goal_count, :category_id, :user_id, :week_id)
    end
end
