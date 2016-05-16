require 'bundler'
require 'colorize'

namespace :tovgdb do
  desc 'Fix Self-Published Records'
  task fix_self_published: :environment do
    system 'clear'
    games = Game.where(self_published: true)
    games.each do |game|
      puts game.name.green
      # puts game.developers(&:name).join(', ').red
      game.developers.each do |dev|
        puts dev.name.red
        puts dev.developer.to_s.blue
        puts dev.publisher.to_s.purple
        dev.publisher = true
        dev.save!
      end
    end
  end
end
