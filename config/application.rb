require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bowling
  class Application < Rails::Application
    config.action_controller.permit_all_parameters = true
  end
end
