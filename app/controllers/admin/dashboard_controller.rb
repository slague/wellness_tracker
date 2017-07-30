class Admin::DashboardController < Admin::BaseController

  def index
    @current_mod = current_week.mod
    @mod_weeks = @current_mod.weeks
    @current_week_achievers = User.achievers(current_week)
    @mods = Mod.all

    # each week will have one randomly chosen winner from all of the week's 100% achievers,
    # this will be stored in the db- each week has one winner

    # we will need a way to randomly select the week's winner, and then store that


    #We'll need a way to see who has achieved 100% of goals each week of the current mod
    # something like......
    # current_mod.weeks.each do |week|
    # User.achievers(week)



  end


end
