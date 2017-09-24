class PageController < ApplicationController
  def home
    @games = Game.includes(:game_images, :developers).published.last(3)
  end
end
