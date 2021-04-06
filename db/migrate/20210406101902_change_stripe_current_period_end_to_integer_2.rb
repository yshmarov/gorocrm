class ChangeStripeCurrentPeriodEndToInteger2 < ActiveRecord::Migration[6.1]
  def change
    remove_column :tenants, :current_period_end
    add_column :tenants, :current_period_end, :string
  end
end
