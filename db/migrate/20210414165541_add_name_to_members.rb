class AddNameToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :first_name, :string
    add_column :members, :middle_name, :string
    add_column :members, :last_name, :string
  end
end
