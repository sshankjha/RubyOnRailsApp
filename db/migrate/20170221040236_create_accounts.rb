class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :acc_no, :unique => true, null: false
      t.integer :user_id
      t.float :balance
      t.integer :state, default = 0
      t.timestamps
      t.references :user
    end
  end
end

