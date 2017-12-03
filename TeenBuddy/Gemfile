source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use sqlite3 as the database for Active Record for development
gem 'sqlite3', :group =>  [:development, :test]
# Use pg as the database for Active Record for development
gem 'pg', group: :production
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Ruby version
ruby "2.4.2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise'

# stripe for payment
gem 'stripe'
gem 'cancancan', '~> 2.0'
gem 'bcrypt', platforms: :ruby

gem 'will_paginate'
# for pageable view
gem 'will_paginate-bootstrap'

#for messages
gem "mailboxer"

gem 'gravatar_image_tag'
gem 'jquery-turbolinks'

gem 'carrierwave'
gem 'mini_magick', '~> 4.5', '>= 4.5.1'
group :development, :test do
  gem 'rspec-rails', '~> 3.6'
end

gem 'activeadmin'
gem 'draper'
gem 'pundit'
group :test, :development do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  #gem 'database_cleaner'
end
gem 'chartkick'

gem 'omniauth-facebook','~> 4.0.0'
gem 'omniauth-twitter'
gem 'omniauth-linkedin'
gem 'faker'
gem 'ui_faces'
gem 'acts-as-taggable-on', '~> 4.0'

gem 'sendgrid-ruby'
gem 'rails_12factor', group: :production
