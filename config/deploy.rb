set :application, "jueso"
set :repository,  "git@github.com:clemsos/jueso.git"
set :user, "jue"
set :deploy_to, "/home/jue/apps/jueso"
set :use_sudo, false
set :git_shallow_clone, 1

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "jue.so"                          # Your HTTP server, Apache/etc
role :app, "jue.so"                          # This may be the same as your `Web` server
role :db,  "jue.so", :primary => true # This is where Rails migrations will run

#
# Setup RVM
#
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2'        # Or whatever env you want it to run in.
set :rvm_type, :user

#
# Setup Bundler
# 
require "bundler/capistrano"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end