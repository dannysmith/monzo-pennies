# frozen_string_literal: true
require 'monzo'
require 'dotenv'
require 'money'
require './models/transaction'

module MonzoPennies
  PotNotFoundError = Class.new(StandardError)

  module Saver
    class << self
      def move_savings!
        configure_monzo

        amount = amount_to_move
        if move_to_savings_pot(amount)
          notify("Saved #{money(amount)} in roundups! 💸")
          close_all_transactions
        else
          notify("Failed to Save your roundups 🤔")
        end
      end

      private

      def move_to_savings_pot(amount)
        pot = Monzo::Pot.all.select{|p| p.name == pot_name}.first
        raise PotNotFoundError, "Pot `#{pot_name}` not found on Monzo" unless pot

        # TODO: Move amount to savings pot
        return true
      end

      def notify(message)
        Monzo::FeedItem.create(account_id, 'basic', title: message,
                                                    image_url: 'http://c.danny.is/putm/piggy-bank.png')
      end

      def close_all_transactions
        Transaction.open.update_all(status: :closed)
      end

      def amount_to_move
        Transaction.open.map{|tx| ((tx.amount / 100) * 100) + 100 - tx.amount}.sum
      end

      def pot_name
        ENV['MONZOPENNIES_SAVINGS_POT_NAME']
      end

      def account_id
        ENV['MONZOPENNIES_ACCOUNT_ID']
      end

      def configure_monzo
        Monzo.configure(ENV['MONZO_ACCESS_TOKEN'])
      end

      def money(amount)
        Money.new(amount, 'GBP').format
      end
    end
  end
end
