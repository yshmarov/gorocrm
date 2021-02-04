class ClientMemberBalance < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :balance, :integer, default: 0, null: false
    add_column :members, :balance, :integer, default: 0, null: false
  end
end
