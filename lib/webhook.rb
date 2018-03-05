# frozen_string_literal: true

require 'monzo'
require 'dotenv'

module MonzoPennies
  module WebHookCreator
    def self.create!
      Dotenv.load
      Monzo.configure(ENV['MONZO_ACCESS_TOKEN'])

      url = "#{ENV['MONZOPENNIES_BASE_URL']}/webhook/tx?token=#{ENV['MONZOPENNIES_WEBHOOK_AUTH_TOKEN']}"
      res = Monzo::Webhook.create(ENV['MONZOPENNIES_ACCOUNT_ID'], url)
      puts "Webhook (id: #{res.id}) created!"
    end
  end
end
