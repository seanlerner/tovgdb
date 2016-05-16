class PageController < ApplicationController
  def home
    @recent_games = Game.last(3)
  end
end
