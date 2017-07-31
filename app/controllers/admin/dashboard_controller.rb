class Admin::DashboardController < Admin::BaseController

  def index
    @mods = Mod.all
    @incomplete_mods = Mod.incomplete_mods
    @current_mod = current_week.mod
    # require "pry"; binding.pry
    @current_week_achievers = User.achievers(current_week)
  end


end
