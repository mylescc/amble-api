source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Core
gem "rails", "~> 5.0.2"
gem "pg", "~> 0.18"
gem "rack-cors"

# Authentication
gem "devise_token_auth"

# Server
gem "foreman"
gem "puma"
gem "puma-heroku"

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "faker"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
