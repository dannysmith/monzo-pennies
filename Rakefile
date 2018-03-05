# frozen_string_literal: true

require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'dotenv/tasks'
require 'dotenv-heroku/tasks'
Dir[File.dirname(__FILE__) + '/lib/*'].each { |f| require f }

task :create_webhooks do
  MonzoPennies::WebHookCreator.create!
end

task save_pennies: :environment do
  MonzoPennies::Saver.move_savings!
end
