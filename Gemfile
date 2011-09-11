source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

# Asset template engines
gem 'haml-rails'
gem 'sass'
gem 'compass', require: false
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

gem 'bluecloth'
gem 'russian', git: "git://github.com/semaperepelitsa/russian.git", branch: 'rails-3.1'
gem 'smart_titles'

group :development, :test do
  # For testing
  gem 'rspec-rails', '~> 2.6.1'
  gem 'autotest'
  gem 'machinist', '>=2.0.0.beta2'
  gem 'mocha'

  # For development
  gem 'sqlite3'
  gem 'nokogiri'
  gem 'awesome_print'
end

group :production do
  gem 'therubyracer-heroku'
  gem 'pg'
  gem 'thin'
end
