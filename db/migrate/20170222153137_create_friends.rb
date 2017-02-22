class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :user_id, null:false, belongs_to: :user
      t.integer :user_id2, null:false, belongs_to: :user
      t.references :user
    end
  end
end
