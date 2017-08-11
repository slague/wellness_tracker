class Admin::DashboardController < Admin::BaseController

  def index
    @mods = Mod.all
    @incomplete_mods = Mod.incomplete_mods
    if current_week
      @current_mod = current_week.mod
    else
      @current_mod = Mod.most_recent
    end
    @current_week_achievers = User.achievers(current_week)
  end

end
