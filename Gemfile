source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'compass', '~> 0.12.alpha.0'
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'haml-rails'
gem 'jquery-rails'

gem 'redcarpet', '~> 2.0.0b5'
gem 'smart_titles'
gem 'russian', '~> 0.6.0'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.6.1'
end

group :test do
  gem 'mocha'
  gem 'machinist', '>=2.0.0.beta2'
end

group :development do
  gem 'guard-livereload'

  gem 'nokogiri'
end

group :production do
  gem 'pg'
  gem 'thin'
end
