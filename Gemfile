source 'https://rubygems.org'
ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# A framework for creating flexible, powerful admin dashboards in Rails.
gem 'administrate', '~> 0.3.0'

# fix for missing dependency in the 'administrate' gem
gem 'bourbon'

# ..a toolkit for file attachments in Ruby applications
gem 'shrine'

# Shrine Dependencies
gem 'mini_magick' # A ruby wrapper for ImageMagick or GraphicsMagick command line
gem 'fastimage' #  is used to extract the image dimensions
gem 'image_processing' # includes some helpers for using ImageMagick
gem 'shrine-memory' # In-memory storage for Shrine (for test env only)

# Rails wrapper for https://github.com/basecamp/trix
# "A rich text editor for everyday writing"
gem 'trix'

# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # automatically run your specs
  gem 'guard-rspec', require: false

  # implements the rspec command for Spring
  gem 'spring-commands-rspec', group: :development

  # deployment-related
  gem 'capistrano', require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'capistrano3-puma', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'

  # Add a comment summarizing the current schema
  gem 'annotate'

  # Mac OS X User Notifications for Guard
  gem 'terminal-notifier-guard', require: false
end

group :test do
  # provides RSpec-compatible one-liners that test common Rails functionality
  gem 'shoulda-matchers', '~> 3.0'

  # A library for setting up Ruby objects as test data
  gem 'factory_girl_rails', '~> 4.0'
end
