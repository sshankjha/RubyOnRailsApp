class AddFromaccountToBorrows < ActiveRecord::Migration[5.0]
  def change
    add_column :borrows, :from_acc, :integer
  end
end
