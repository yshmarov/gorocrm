class RemoveAmountFromCharges < ActiveRecord::Migration[6.0]
  def change
    remove_column :charges, :amount
  end
end
