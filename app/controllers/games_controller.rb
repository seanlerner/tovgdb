class GamesController < InheritedResources::Base
  def index
    @games = Game.published
  end

  def show
    @game = Game.published.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.name = params[:game][:name]
    if @game.save
      flash.notice 'Thank-you for your submission.'
      redirect_to root_page
    else
      # binding.pry
      render :new
    end
  end
end
