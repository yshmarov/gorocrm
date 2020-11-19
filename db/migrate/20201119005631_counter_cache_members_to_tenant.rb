class CounterCacheMembersToTenant < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :members_count, :integer, default: 0, null: false
  end
end
