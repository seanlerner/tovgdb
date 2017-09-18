class TovgdbSearch
  attr_reader :criteria, :results

  def initialize(params)
    @criteria = []
    @games = {}
    @params = params
    populate_games
    @results = @games
  end

  private

  def populate_games
    populate_games_from_keywords
    populate_games_from_tag_classes
    populate_games_from_modes
    ensure_games_satisfy_all_criteria if @params[:match_type] == 'all'
    sort_games_by_score
  end

  def populate_games_from_keywords
    keywords = @params[:keywords]
    return if keywords.blank?
    @criteria << criteria = { category: :keywords, criteria: keywords }

    games_from_elastic_search =
      Game.search_for(keywords, @params[:match_type])
          .sort_by { |elastic_search_result| elastic_search_result.id.to_i }
    return unless games_from_elastic_search
    game_ids = games_from_elastic_search.map { |game| game.id.to_i }
    games_from_database = Game.where(id: game_ids, published: true)
    add_games_to_results(keyword_results_merged(games_from_database, games_from_elastic_search, criteria))
  end

  def keyword_results_merged(games_from_database, games_from_elastic_search, criteria)
    Hash[
      games_from_database.zip(games_from_elastic_search).map do |item|
        database_game = item[0]
        elastic_search_game = item[1]
        [database_game.id, { game: database_game, elastic_search: elastic_search_game, criteria: criteria }]
      end
    ]
  end

  def populate_games_from_tag_classes
    [Genre, Style, Theme, Platform, Engine, Community].each do |tag_class|
      tag_symbol = tag_class.symbol_pluralized
      if @params[tag_symbol]
        tag_ids = @params[tag_symbol][:ids].reject(&:empty?)
        populate_games_from_tag_class(tag_class, tag_ids)
      end
    end
  end

  def populate_games_from_tag_class(tag_class, tag_ids)
    tag_ids.each do |tag_id|
      tag = tag_class.find(tag_id)
      @criteria << criteria = { category: tag_class.symbol_pluralized, criteria: tag.name }
      tag.published_games.each do |game|
        game_data = { game: game, criteria: criteria }
        add_game_to_results(game_data)
      end
    end
  end

  def populate_games_from_modes
    %i[single_player multiplayer local_play online_play coop_play competitive_play].each do |mode|
      next unless @params[mode]
      @criteria << criteria = { category: :modes, criteria: Mode.find(mode).name }
      Game.published.includes(:game_images).send(mode).find_each do |game|
        game_data = { game: game, criteria: criteria }
        add_game_to_results(game_data)
      end
    end
  end

  def add_games_to_results(games_found)
    games_found.each do |_, game_data|
      add_game_to_results(game_data)
    end
  end

  def add_game_to_results(game_data)
    game_id = game_data[:game].id
    create_result(game_id, game_data) unless @games[game_id]
    add_criteria_to_result(game_id, game_data)
    add_score_to_result(game_id, game_data)
    add_elastic_search_to_result(game_id, game_data)
  end

  def create_result(game_id, game_data)
    @games[game_id] = { game: game_data[:game], criteria: [], score: 0 }
  end

  def add_criteria_to_result(game_id, game_data)
    @games[game_id][:criteria] << game_data[:criteria]
  end

  def add_score_to_result(game_id, game_data)
    elastic_search = game_data[:elastic_search]
    @games[game_id][:score] += elastic_search ? elastic_search._score : 0.05
  end

  def add_elastic_search_to_result(game_id, game_data)
    elastic_search = game_data[:elastic_search]
    return unless elastic_search
    @games[game_id][:elastic_search] = elastic_search
  end

  def ensure_games_satisfy_all_criteria
    @games.select! { |_, game_data| game_data[:criteria] == @criteria }
  end

  def sort_games_by_score
    @games = @games.sort_by { |_, game| game[:score] }.reverse.map(&:last)
  end
end
