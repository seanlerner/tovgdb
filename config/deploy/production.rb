role :app, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"
role :web, "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"
role :db,  "#{ENV['CAPISTRANO_USER']}@#{ENV['CAPISTRANO_SERVER']}"

server ENV['CAPISTRANO_SERVER'], user: ENV['CAPISTRANO_USER'], roles: %w[web app]

set :stage,     :production
set :deploy_to, '/home/deploy/tovgdb'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  before :starting, :ensure_user do
    git_repo = Git.open(Dir.pwd)
    if git_repo.status.changed != {}
      message = 'Changes to code must be committed first before deploying.'.red
      abort(message)
    elsif git_repo.revparse('HEAD') != git_repo.revparse('origin/master')
      message = 'Changes have been commited but not pushed. Please push first before deploying.'.red
      abort(message)
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing,  'deploy:cleanup'
end
