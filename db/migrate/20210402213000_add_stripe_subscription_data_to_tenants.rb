class AddStripeSubscriptionDataToTenants < ActiveRecord::Migration[6.1]
  def change
    add_column :tenants, :plan, :string
    add_column :tenants, :subscription_status, :string, default: "incomplete"
    add_column :tenants, :stripe_customer_id, :string
    add_column :tenants, :current_period_end, :datetime
  end
end
