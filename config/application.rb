require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module FilmProjectRails
  class Application < Rails::Application

    #the 0 guarantees that it is loaded first
    ENV['AWS_ACCESS_KEY_ID'] ||= "AKIAIB2PQYR2LSGIG4BA"
    ENV['AWS_SECRET_ACCESS_KEY'] ||= "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"
    ENV['FOG_DIRECTORY'] ||= "stagecoachlocal-assets"
    ENV['FOG_PROVIDER'] ||= "AWS"
    ENV['S3_BUCKET_NAME'] ||= "stagecoachlocal-assets"
    ENV['GMAIL_PASSWORD'] ||= "northwestern2013"
    ENV['GMAIL_USERNAME'] ||= "admin@projectstagecoach.com"
    ENV['GOOGLE_OAUTH_SCOPE'] ||= "https://www.google.com/m8/feeds  https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email"
    ENV['GOOGLE_OAUTH_STATE'] ||= ""
    ENV['GOOGLE_OAUTH_RESPONSE_TYPE'] ||= "code"
    ENV['GOOGLE_OAUTH_CLIENT_ID'] ||= "630898205217-pt1ife1pkrqmt5k644fvodp5o3cb5737.apps.googleusercontent.com"
    ENV['GOOGLE_OAUTH_CLIENT_SECRET'] ||= "h5J7p-dk5bBd2QG7KVEJH_23"
    ENV['GOOGLE_OAUTH_REDIRECT_URI'] ||= "http://localhost:3000/oauth2callback"
    ENV['REDISTOGO_URL'] ||= "redis://projectstagecoach:bace5e5f2538a03e261356a364f3cdab@herring.redistogo.com:9865"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    ActiveSupport::Deprecation.silenced = true

    config.app_generators.scaffold_controller = :scaffold_controller
    #for active admin and devise
    config.assets.initialize_on_precompile = false
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
     config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
