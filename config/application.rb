# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'Brasilia'

    config.active_storage.variant_processor = :mini_magick
  end
end
