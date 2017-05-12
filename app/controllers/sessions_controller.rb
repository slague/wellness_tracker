class SessionsController < ApplicationController

  def create
    @user= User.find_or_create_by(census_uid: omniauth_options[:uid])
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to user_goals_path(@user), notice: "Welcome Back"
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
    # If we want to gather more info, throw a byebug when we get census stuff working (in byrbug look at request.env["omniauth.auth"])
    # byebug
    if auth_hash = request.env["omniauth.auth"]
      {
        uid: auth_hash["uid"].to_i
      }
    end
  end

end
