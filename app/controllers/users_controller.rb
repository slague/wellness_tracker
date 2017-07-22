class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    if @user.save
      @user.send_reminder
      flash[:success] = 'Account updated.'
      redirect_to user_goals_path
    else
      flash.now[:danger] = "Please enter a name and cohort."
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :cohort, :phone_number, :wants_reminder?)
  end
end
