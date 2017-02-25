class FixColumnNameTransactionType < ActiveRecord::Migration[5.0]
  def up
    rename_column :transactions, :type, :trans_type
  end
end
