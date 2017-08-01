class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def update
    current_user.update(user_params)

    if current_user.save
      flash[:success] = 'Account updated.'
      redirect_to user_goals_path
    else
      flash.now[:danger] = "#{current_user.errors.messages.first[0]} #{current_user.errors.messages.first[1][0]}"
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :cohort, :phone_number, :wants_reminder)
  end
end
