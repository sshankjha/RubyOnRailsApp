class AddUsernameToBorrows < ActiveRecord::Migration[5.0]
  def change
    add_column :borrows, :user_name, :string
  end
end
