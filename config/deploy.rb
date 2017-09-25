require 'git'
require 'colorize'
require 'dotenv'

Dotenv.load('~/.local/tovgdb/.env')

set :stages,          ['staging', 'production']
set :default_stage,   'staging'
set :application,     'tovgdb'
set :repo_url,        'git@github.com:seanlerner/tovgdb.git'
set :rbenv_path,      '/home/deploy/.rbenv/'

set :linked_files,    %w[config/database.yml .env]
set :linked_dirs,     %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]
set :bundle_binstubs, nil

set :rbenv_type,      :user
set :rbenv_ruby,      '2.4.2'
set :rbenv_prefix,    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins,  %w[rake gem bundle ruby rails]
set :rbenv_roles,     :all

set :keep_releases,   20
set :format,          :pretty
set :log_level,       :info
