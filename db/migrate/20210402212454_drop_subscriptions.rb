class DropSubscriptions < ActiveRecord::Migration[6.1]
  def change
    drop_table :charges
    drop_table :subscriptions
    drop_table :plans
  end
end
