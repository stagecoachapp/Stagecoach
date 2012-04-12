require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

ENV['AWS_ACCESS_KEY_ID'] = 'AKIAIB2PQYR2LSGIG4BA'
ENV['AWS_SECRET_ACCESS_KEY'] = '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'
ENV['FOG_DIRECTORY'] = 'stagecoachlocal-assets'
ENV['FOG_PROVIDER'] = 'AWS'
ENV['GMAIL_PASSWORD'] = 'northwestern2013'
ENV['GMAIL_USERNAME'] = 'projectstagecoach@gmail.com'

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
