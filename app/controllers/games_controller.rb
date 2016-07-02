class GamesController < InheritedResources::Base
  def index
    @games = Game.published
  end

  def show
    @game = Game.published.find(params[:id])
  end
end
