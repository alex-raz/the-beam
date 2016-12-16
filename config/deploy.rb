# config valid only for current version of Capistrano
lock '3.7.0'

PROVISION_VARS = YAML.load_file('config/provision/group_vars/all')

set :application, PROVISION_VARS['app_name']
set :repo_url, 'git@github.com:alexeyrazuvaev/the-beam.git'
set :user, PROVISION_VARS['deploy_user']

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :use_sudo, false
set :deploy_via, :remote_cache
set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa)
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :linked_dirs, %w{ log tmp/pids tmp/cache tmp/sockets public/uploads }
append :linked_files, '.env'

# For capistrano-puma
set :puma_init_active_record, true

# For capistrano-bundler
set :bundle_path, -> { shared_path.join('vendor', 'bundle') }
set :bundle_flags, '--deployment'

# some tweaks
namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "\n\e[0;31m WARNING: HEAD is not the same as origin/#{fetch(:branch)}\e[0m\n"
        puts "\e[0;32m Run `git push` to sync changes.\e[0m"
        exit
      end
    end
  end

  desc 'Create db if needed'
  task :createdb do
    on roles(:app) do
      within release_path do
        execute :bundle, "exec rake RAILS_ENV=#{fetch(:rails_env)} db:create"
      end
    end
  end

  desc 'Copy production version of .env file'
  task :copy_env_file do
    on roles(:app) do
      env_file_path = ENV['env_file_path']
      upload!(env_file_path, "#{shared_path}/.env") if env_file_path
    end
  end

  before :starting, :check_revision
  before 'check:linked_files', :copy_env_file
  before :migrate, :createdb
end
