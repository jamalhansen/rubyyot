default_run_options[:pty] = true

# be sure to change these
set :user, 'rubyyotc'
set :domain, 'rubyyot.com'
set :application, 'rubyyot.com'

# the rest should be good
set :repository,  "git://github.com/rubyyot/rubyyot.git" 
set :deploy_to, "/home/#{user}/apps/#{domain}" 
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end