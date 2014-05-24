root = "/home/elsant/apps/glash/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.glash.sock"
worker_processes 2
timeout 30

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end

# working_directory File.expand_path("../..", __FILE__)
# worker_processes 1
# listen "/home/elsant/glash/tmp/sockets/unicorn.sock"
# #listen 3000
# timeout 30
# pid "/home/elsant/glash/tmp/pids/unicorn_glash.pid"
# stdout_path "/home/elsant/glash/log/unicorn.log"
# stderr_path "/home/elsant/glash/log/unicorn.log"