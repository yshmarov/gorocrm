class RemovePlanFromTenants < ActiveRecord::Migration[6.0]
  def change
    remove_column :tenants, :plan
  end
end
