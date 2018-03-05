# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Sinatra and Servers
gem 'dotenv'
gem 'dotenv-heroku'
gem 'puma'
gem 'rake'
gem 'sinatra'

# Libs
gem 'httparty'
gem 'money'
gem 'monzo'

# Database
gem 'pg'
gem 'sinatra-activerecord'

group :test, :development do
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-doc'
  gem 'rspec'
  gem 'rubocop'
end
