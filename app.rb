# frozen_string_literal: true
require 'json'
require 'sinatra/base'
require 'sinatra/activerecord'

module MonzoPennies
  class App < Sinatra::Base
    set :database_file, 'config/database.yml'

    post '/webhook/tx' do
      halt(401, { message: 'Unathorized' }.to_json) unless params[:token] == ENV['MONZOPENNIES_WEBHOOK_AUTH_TOKEN']

      data = JSON.parse(request.body.read)['data']
      tx =  Transaction.new(
        monzo_id: data['id'],
        monzo_created: data['created'],
        description: data['description'],
        amount: data['amount'],
        currency: data['currency']
      )

      unless tx.save
        puts "Error: Transaction #{data['id']} could not be saved!"
      end
    end
  end
end
