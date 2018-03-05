# frozen_string_literal: true

# This represents a single transaction in Monzo
class Transaction < ActiveRecord::Base
  enum status: { open: 0, closed: 1 }

  # Validations
  validates :monzo_id, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :monzo_created, presence: true

  # Scopes
  scope :rounduppable, -> { open.where('amount < ?', 0) }
end
