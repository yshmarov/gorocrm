class CashAccountBelongsToTenant < ActiveRecord::Migration[6.1]
  def change
    add_reference :cash_accounts, :tenant, foreign_key: true, null: false
  end
end
