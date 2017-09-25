role :app, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"
role :web, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"
role :db,  "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"

server ENV['CAPISTRANO_SERVER'], user: ENV['CAPISTRANO_USER'], roles: %w[web app]

set :stage,     :staging
set :deploy_to, '/home/deploy/staging'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing,  'deploy:cleanup'
end
