class AddRolesToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :roles, :jsonb, null: false, default: {}
    add_index  :members, :roles, using: :gin
  end
end
