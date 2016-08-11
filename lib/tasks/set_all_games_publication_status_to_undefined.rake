require 'bundler'
require 'colorize'

namespace :tovgdb do
  desc 'Sets all games publication status to undefined'
  task set_all_games_publication_status_to_undefined: :environment do
    system 'clear'
    Game.find_each do |game|
      puts "#{game.name.green}: #{game.publication_status}"
      game.publication_status = 'undefined'
      game.save!
    end
  end
end
