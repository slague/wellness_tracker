class Admin::DashboardController < Admin::BaseController

  def index
    @mods = Mod.all
    @incomplete_mods = Mod.incomplete_mods
    @current_mod = current_week.mod
    @current_week_achievers = User.achievers(current_week)

    # MOD WINNERS
    # We'll need a way to see who has achieved 100% of goals each week of the current mod
    # something like......
    # current_mod.weeks.each do |week|
    # User.achievers(week)
    # all users who achieve 100% of goals every week of hte mod win an end of mod prize!

  end


end
