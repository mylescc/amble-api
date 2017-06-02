source "https://rubygems.org"
ruby "2.3.4"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Core
gem "pg", "~> 0.18"
gem "rack-cors"
gem "rails", "~> 5.0.2"

# Authentication
gem "devise_token_auth"

# Server
gem "foreman"
gem "puma"
gem "puma-heroku"
gem "rollbar"

group :development, :test do
  gem "codeclimate-test-reporter", "~> 1.0.0"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails"
end

group :test do
  #gem "shoulda-matchers", require: false
  #gem "shoulda-callback-matchers"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
