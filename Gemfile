source 'http://rubygems.org'

gem 'rails', '3.0.10'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
	gem 'thin'
	gem 'pg'
end

group :development do
	gem 'unicorn'
	gem 'sqlite3'
end

group :development, :test do
	gem "cucumber-rails"
	gem "capybara"
	gem "rspec-rails", ">= 2.0.1"
end
