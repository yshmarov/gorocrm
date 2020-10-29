class ChargesSubscriptionIdCanBeNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :charges, :subscription_id, true
  end
end
