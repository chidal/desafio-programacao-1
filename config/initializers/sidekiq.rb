require 'sidekiq'
require 'sidekiq-scheduler'

# Funcionalidade de Scheduler em um arquivo .yml
Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../scheduler.yml', File.dirname(__FILE__)))
    Sidekiq::Scheduler.reload_schedule!
  end
end
