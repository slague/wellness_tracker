class GoalsController < ApplicationController

  def index
    @categories = Category.all
  end

end
