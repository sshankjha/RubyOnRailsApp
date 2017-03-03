class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :from
      t.integer :to
      t.integer :kind
      t.integer :state
      t.decimal :amount
      t.integer :user_id
      t.datetime :added
      t.datetime :confirmed
      t.timestamps
    end
  end
end
