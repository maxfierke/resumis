node[:deploy].each do |application, deploy|
  if application == 'resumis' # replace api with your app
    run "bundle exec rake sidekiq:start"
  end
end

run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
