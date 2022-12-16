source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem 'prawn'
#As of Prawn 1.2.0, Prawn::Table has been extracted into its own semi-officially supported gem.
gem 'prawn-table'

gem 'open-uri', '~> 0.3.0'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-rails'
end

group :development do
  gem "web-console"


end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
