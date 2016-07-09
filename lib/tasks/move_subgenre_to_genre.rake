require 'bundler'
require 'colorize'

namespace :tovgdb do
  desc 'Move Subgenre tags into Genre and retire Subgenre tag'
  task move_subgenre_to_genre: :environment do
    system 'clear'
    Subgenre.all.each do |subgenre|
      genre = Genre.new(name: subgenre.name, description: subgenre.description)
      print "Attempting to create a #{genre.name.yellow} genre tag..."
      puts genre.save ? 'success!'.green : 'already exists, no need!'.yellow
    end
  end
end
