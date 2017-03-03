class CreateBorrows < ActiveRecord::Migration[5.0]
  def change
    create_table :borrows do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :friend_name
      t.decimal :amount
      t.integer :state

      t.timestamps
    end
  end
end
