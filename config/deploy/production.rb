application_master = IO.readlines('config/provision/production')[1].delete!("\n")

role :app, application_master
role :web, application_master
role :db,  application_master

set :rails_env, 'production'
set :keep_releases, 5
