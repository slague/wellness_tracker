class ModsController < ApplicationController

  def index
    @mods =  Mod.all
  end
end
