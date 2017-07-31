class WeeksController < ApplicationController
  def index
    @weeks = Week.all
    @mods = Mod.all
  end
end
