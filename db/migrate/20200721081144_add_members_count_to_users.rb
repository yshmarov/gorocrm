class AddMembersCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :members_count, :integer, default: 0, null: false
  end
end
