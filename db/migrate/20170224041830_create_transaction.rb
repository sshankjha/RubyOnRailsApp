class CreateTransaction < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id, null: false
      t.integer :from, null: false
      t.integer :to, null:false
      t.integer :status, default = 0
      t.integer :type, null: false
      t.float :amount, null: false
      t.references :user
    end
  end
end
