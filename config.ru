# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv'
require './app'

# Load environment variables and libraries
Dotenv.load
Dir[File.dirname(__FILE__) + '/lib/*'].each { |f| require f }

# Run application
run MonzoPennies::App
