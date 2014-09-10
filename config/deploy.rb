require "rvm/capistrano"
require "bundler/capistrano"

set :application, "glash"
set :scm, :git
set :scm_username, "IvanVP"
set :repository, "git://github.com/IvanVP/glash.git"
set :branch, "master"
server "glash.ru", :web, :app, :db, :primary => true
set :port, 30000 
# ssh_options[:port] = 30000
# ssh_options[:keys] = "/home/ivan/.ssh/id_rsa.pub"
set :user, "elsant"
set :group, "elsant"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false
set :deploy_via, :remote_cache

# set :copy_strategy, :export


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/config/initializers"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"

    put File.read("config/initializers/devise.example.rb"), "#{shared_path}/config/initializers/devise.rb"
    put File.read("config/initializers/secret_token.example.rb"), "#{shared_path}/config/initializers/secret_token.rb"

    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    run "ln -nfs #{shared_path}/config/initializers/devise.rb #{release_path}/config/initializers/devise.rb"
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"


  # namespace :assets do

  #   task :precompile, :roles => :web do
  #     from = source.next_revision(current_revision)
  #     if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
  #       run_locally("RAILS_ENV=#{rails_env} rake assets:clean && RAILS_ENV=#{rails_env} rake assets:precompile")
  #       run_locally "cd public && tar -jcf assets.tar.bz2 assets"
  #       top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
  #       run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
  #       run_locally "rm public/assets.tar.bz2"
  #       run_locally("rake assets:clean")
  #     else
  #       logger.info "Skipping asset precompilation because there were no asset changes"
  #     end
  #   end

  #   task :symlink, roles: :web do
  #     run ("rm -rf #{latest_release}/public/assets &&
  #           mkdir -p #{latest_release}/public &&
  #           mkdir -p #{shared_path}/assets &&
  #           ln -s #{shared_path}/assets #{latest_release}/public/assets")
  #   end
  # end



  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end


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



# namespace :deploy do
# task :start do ; end
# task :stop do ; end
# desc "Restart the application"
# task :restart, :roles => :app, :except => { :no_release => true } do
# run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
# end
# # desc "Copy the database.yml file into the latest release"
# # task :copy_in_database_yml do
# # run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
# # end
# end
# before "deploy:assets:precompile", "deploy:copy_in_database_yml"