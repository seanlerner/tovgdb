generate_new_search_index = false

if generate_new_search_index && (Rails.env.development? || Rails.env.production?)
  @logger = Rails.logger

  def elasticsearch_failed
    @logger.error 'Warning! Could not connect to elasticsearch!'.red
    @logger.error 'Warning! Search functionality will be disabled. Please address and restart rails for search functionality.'.red
  end

  def delete_games_index
    @logger.info 'Attempting to Delete Games Index...'.blue
    Game.__elasticsearch__.client.indices.delete index: Game.index_name
    @logger.info 'Index Deleted.'.green
  rescue Elasticsearch::Transport::Transport::Errors::NotFound
    @logger.error 'Could not Delete Games Index for elasticsearch. Maybe one did not exist?'.red
  rescue Faraday::ConnectionFailed
    elasticsearch_failed
  end

  def create_games_index
    @logger.info 'Attempting to Create Games Index...'.blue
    Game.__elasticsearch__.client.indices.create index: Game.index_name, body: { settings: Game.settings.to_hash, mappings: Game.mappings.to_hash }
    @logger.info 'Index Created.'.green
    @elasticsearch_running = true
  rescue Faraday::ConnectionFailed
    elasticsearch_failed
  end

  def index_games
    @logger.info 'Attempting to Index Games...'.blue
    Game.__elasticsearch__.import
  rescue Faraday::ConnectionFailed
    elasticsearch_failed
  else
    @logger.info 'Games Indexed.'.green
    @elasticsearch_running = true
  end

  delete_games_index
  create_games_index
  index_games if @elasticsearch_running
end
