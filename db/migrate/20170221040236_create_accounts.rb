class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :acc_no
      t.float :balance
      t.integer :state, default = 0
      t.timestamps
      t.references :user
    end
  end
end
