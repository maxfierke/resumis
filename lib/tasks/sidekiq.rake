SIDEKIQ_PID = File.expand_path("../../../tmp/pids/sidekiq.pid", __FILE__)

namespace :sidekiq do
  def sidekiq_is_running?
    File.exists?(SIDEKIQ_PID) && system("ps x | grep `cat #{SIDEKIQ_PID}` 2>&1 > /dev/null")
  end

  desc "Start sidekiq daemon."
  task :start => :stop do
    if sidekiq_is_running?
      puts "Sidekiq is already running."
    else
      sh "bundle exec sidekiq -d" # -d means daemon
    end
  end

  desc "Stop sidekiq daemon."
  task :stop do
    if File.exists? SIDEKIQ_PID
      sh "sidekiqctl stop #{SIDEKIQ_PID}"
    end
  end

  desc "Show status of sidekiq daemon."
  task :status do
    if sidekiq_is_running?
      puts "Sidekiq is running"
    else
      puts "Sidekiq is stopped"
    end
  end
end
