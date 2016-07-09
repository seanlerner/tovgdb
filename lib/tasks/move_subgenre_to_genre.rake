require 'bundler'
require 'colorize'

def summary_of_database
  [Game, Genre, Subgenre, GamesGenre, GamesSubgenre].each do |tag|
    puts "# of #{tag}s: #{tag.count.to_s.yellow}"
  end
end

namespace :tovgdb do
  desc 'Move Subgenre tags into Genre and retire Subgenre tag'
  task move_subgenre_to_genre: :environment do
    system 'clear'
    summary_of_database
    Subgenre.all.each do |subgenre|
      puts "Finding or creating #{subgenre.name.yellow} genre tag."
      genre = Genre.find_or_create_by(name: subgenre.name)
      unless genre.description
        genre.description = subgenre.description
        genre.save!
      end
      subgenre.games.each do |game|
        puts "Associating #{game.name} with tag #{genre.name}."
        GamesGenre.find_or_create_by(game: game, genre: genre)
      end
      puts "Destroying #{subgenre.name} subgenre tag."
      subgenre.destroy!
    end
    summary_of_database
  end
end
