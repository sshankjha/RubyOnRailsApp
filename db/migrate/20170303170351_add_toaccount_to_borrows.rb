class AddToaccountToBorrows < ActiveRecord::Migration[5.0]
  def change
    add_column :borrows, :to_acc, :integer
  end
end
