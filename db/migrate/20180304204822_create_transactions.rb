class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string   :monzo_id, null: false
      t.time     :monzo_created, null: false
      t.string   :description
      t.integer  :amount, null: false
      t.string   :currency
      t.integer  :status, default: 0

      t.timestamps
    end

    add_index :transactions, :monzo_id, unique: true
  end
end
