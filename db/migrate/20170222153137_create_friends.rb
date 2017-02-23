class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends, {:id => false} do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :fname, null: false
    end
    execute "ALTER TABLE friends ADD PRIMARY KEY (user_id,friend_id);"

  end
end
