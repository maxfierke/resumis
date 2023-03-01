home = ENV["RESUMIS_DEPLOY_ROOT"]
if home
  directory home
end

port ENV["RESUMIS_HTTP_PORT"] || ENV["PORT"]
workers (ENV["WEB_CONCURRENCY"] || 2).to_i
worker_timeout 15
preload_app!

unless ENV["RAILS_LOG_TO_STDOUT"]
  stdout_redirect "log/puma.log", "log/puma.err.log"
end

before_fork do
  ActiveRecord::Base.connection.disconnect!
end

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
