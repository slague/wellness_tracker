class Admin::WeeksController < ApplicationController


  def new
    @mods = Mod.all
  end

  def create
    @mods = Mod.all
    Week.set_weeks((params["number_of_weeks"].to_i), (params["start_date"].to_date), (params["mod_id"].to_i))

      redirect_to admin_weeks_path
  end

  private

  def week_params(my_params)
    my_params.permit(:number_of_weeks, :start_date, :mod_id)
  end
end
