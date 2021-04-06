class ChangeStripeCurrentPeriodEndToInteger < ActiveRecord::Migration[6.1]
  def change
    remove_column :tenants, :current_period_end, :integer
    add_column :tenants, :current_period_end, :integer
  end
end
