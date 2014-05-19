require "rvm/capistrano"
require "bundler/capistrano"

set :application, "glash"
set :scm, :git
set :repository, "git://github.com/IvanVP/glash.git"
server "glash.ru", :web, :app, :db, :primary => true
ssh_options[:port] = 30000
ssh_options[:keys] = "/home/ivan/.ssh/id_rsa.pub"
set :user, "elsant"
set :group, "elsant"
set :deploy_to, "/home/elsant/glash"
set :use_sudo, false
set :deploy_via, :copy
set :copy_strategy, :export

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts



namespace :deploy do
task :start do ; end
task :stop do ; end
desc "Restart the application"
task :restart, :roles => :app, :except => { :no_release => true } do
run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
end
# desc "Copy the database.yml file into the latest release"
# task :copy_in_database_yml do
# run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
# end
end
before "deploy:assets:precompile", "deploy:copy_in_database_yml"