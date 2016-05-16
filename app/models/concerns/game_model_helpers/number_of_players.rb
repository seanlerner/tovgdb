module GameModelHelpers
  module NumberOfPlayers
    def single_player_only?
      maximum_number_of_players.to_i == 1 ? true : false
    end

    def multiplayer_only?
      (minimum_number_of_players.to_i > 1) || (minimum_number_of_players != 1 && ((maximum_number_of_players.to_i > 1) || multiplayer_modes?))
    end

    def single_player_and_multiplayer?
      minimum_number_of_players == 1 && (multiplayer_modes? || maximum_number_of_players.to_i > 1)
    end

    def number_of_players_defined?
      maximum_number_of_players? || (minimum_number_of_players? && minimum_number_of_players != 1)
    end

    def number_of_players_as_numerals
      if minimum_number_of_players == maximum_number_of_players || (minimum_number_of_players.nil? ^ maximum_number_of_players.nil?)
        "#{minimum_number_of_players || maximum_number_of_players} players"
      else
        "#{minimum_number_of_players || '?'}-#{maximum_number_of_players || '?'} players"
      end
    end

    def number_of_players_for_display
      if single_player_only?
        'Single-player'
      elsif number_of_players_defined?
        number_of_players_as_numerals
      elsif multiplayer_only?
        'Multiplayer'
      elsif single_player_and_multiplayer?
        'Single-player, Multiplayer'
      end
    end
  end
end
