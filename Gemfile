source 'http://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'activeadmin'

gem 'json'
gem 'pg'
gem "twitter-bootstrap-rails", "~> 2.0rc0", :group => :assets
# Gems used only for assets and not required
# in production environments by default.
gem 'thin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'asset_sync'
end

gem 'jquery-rails'
gem 'omniauth-facebook'
gem 'ckeditor_rails', :require => 'ckeditor-rails'

gem 'mobile-fu', :git => 'git://github.com/benlangfeld/mobile-fu.git'
group :development do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'watir-webdriver'
  #comment/uncomment next 3 lines for ruby-debug
  gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
  gem 'ruby-debug19'
  #
  ##### run this to get this working: bundle config build.ruby-debug-base19 --with-ruby-include=$rvm_path/src/ruby-1.9.3-p0/
  #
  #gem 'ruby-debug19'
  #gem 'ruby-debug-base19', :git => 'https://github.com/tribune/ruby-debug-base19.git'
  #gem 'linecache19', :git => 'git@github.com:chuckg/linecache19.git', :branch => "0_5_13/dependencies"
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  #gem "rails-dev-tweaks", "~> 0.6.1"
 # gem 'ruby-debug19'
end

group :production do
  gem 'paperclip'
  gem 'aws-s3'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

