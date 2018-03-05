# frozen_string_literal: true

require 'json'
require 'sinatra/base'
require 'sinatra/activerecord'

module MonzoPennies
  class App < Sinatra::Base
    set :database_file, 'config/database.yml'

    post '/webhook/tx' do
      unless params[:token] == ENV['MONZOPENNIES_WEBHOOK_AUTH_TOKEN']
        puts "[MONZOPENNIES] Halting. Webhook auth token incorrect or not present."
        halt(401, { message: 'Unathorized' }.to_json)
      end

      puts "[MONZOPENNIES] Webhook recieved."
      data = JSON.parse(request.body.read)['data']

      puts "[MONZOPENNIES] Recieved transaction #{data['id']} from Monzo"

      unless data['include_in_spending']
        puts "[MONZOPENNIES] Transaction does not count towards spending. Not saving."
        return
      end

      tx = Transaction.new(
        monzo_id: data['id'],
        monzo_created: data['created'],
        description: data['description'],
        amount: data['amount'],
        currency: data['currency']
      )

      if tx.save
        puts "[MONZOPENNIES] Transaction #{tx.id} (#{tx.monzo_id})saved."
      else
        puts "[MONZOPENNIES] Error: Transaction #{data['id']} could not be saved!"
      end
    end
  end
end
