require 'git'
require 'colorize'
require 'dotenv'

Dotenv.load('~/.local/tovgdb/.env')

set :application, 'tovgdb'
set :repo_url, 'git@github.com:seanlerner/tovgdb.git'
set :rbenv_path, '/home/deploy/.rbenv/'

set :deploy_to, '/home/deploy/tovgdb'

set :linked_files, %w(config/database.yml .env)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)
set :bundle_binstubs, nil

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all

set :keep_releases, 20
set :format, :pretty
set :log_level, :info

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
  after :finishing, 'deploy:cleanup'
end
