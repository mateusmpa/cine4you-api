require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('CINE4YOU_API_REDIS_URL', 'redis://redis:6379/0') }

  Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/sidekiq_schedule.yml')
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('CINE4YOU_API_REDIS_URL', 'redis://redis:6379/0') }
end
