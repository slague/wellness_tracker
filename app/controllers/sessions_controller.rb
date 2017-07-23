class SessionsController < ApplicationController

  def create
    @user= User.find_or_initialize_by(github_id: omniauth_options[:uid])

    if @user.persisted?
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.name}."
      redirect_to user_goals_path

    else
      @user.save
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user)
    end
  end

  def show
  end

  def new
    redirect_to '/auth/github'
  end

  def destroy
    reset_session
    flash[:success] = "Successfully logged out."

    redirect_to root_path
  end


  private

  def omniauth_options
    if auth_hash = request.env["omniauth.auth"]
      {
        uid: auth_hash["uid"].to_i
      }
    end
  end

end
