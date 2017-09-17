class PageController < ApplicationController
  def home
    @games = Game.published.last(3)
  end
end
