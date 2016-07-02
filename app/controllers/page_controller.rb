class PageController < ApplicationController
  def home
    @recent_games = Game.published.last(3)
  end
end
