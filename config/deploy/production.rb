role :app, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"
role :web, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"
role :db, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"

server ENV['CAPISTRANO_SERVER'], user: ENV['CAPISTRANO_USER'], roles: %w(web app), my_property: :my_value

set :stage, :production

server ENV['CAPISTRANO_SERVER'], user: ENV['CAPISTRANO_USER'], roles: %w(web app)
