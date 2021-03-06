require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# config.active_job.queue_adapter = :delayed_job

module WellnessTracker
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Mountain Time (US & Canada)'
    config.active_record.default_timezone = :local
    # configure scaffolding
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :rspec,
                       fixture: false,
                       view_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       request_specs: false,
                       routing_specs: false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.jbuilder        false
      g.assets          false
    end

  end
end
