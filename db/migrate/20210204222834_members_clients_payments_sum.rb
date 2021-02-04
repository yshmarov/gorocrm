class MembersClientsPaymentsSum < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :payments_sum, :integer, null: false, default: 0
    add_column :clients, :payments_sum, :integer, null: false, default: 0
  end
end
