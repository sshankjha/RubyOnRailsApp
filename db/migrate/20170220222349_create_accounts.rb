class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null = false
      t.integer :acc_no
      t.float :balance, null = false, default = 0
      t.string :state, null = false

      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
