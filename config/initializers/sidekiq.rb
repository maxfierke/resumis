redis_url = ENV['REDIS_URL'].presence || 'redis://localhost:6379/1'
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
