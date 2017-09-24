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
    @game = Game.new(game_params)

    if @game.save
      flash.notice = 'Thank-you for your submission. We will review and published it as soon as possible.'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def game_params
    params
      .require(:game)
      .permit(
        :ads,
        :competitive_play,
        :coop_play,
        :donation,
        :free,
        :free_trial,
        :freemium,
        :initial_release_on,
        :local_play,
        :long_description,
        :maximum_number_of_players,
        :minimum_number_of_players,
        :name,
        :not_available,
        :online_play,
        :pay,
        :submission_notes,
        :submitted_by_contact_info,
        :engine_id,
        :series_id,
        developer_ids: [],
        publisher_ids: [],
        community_ids: [],
        genre_ids:     [],
        platform_ids:  [],
        style_ids:     [],
        theme_ids:     []
      )
  end
end
