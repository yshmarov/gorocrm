class AddSuperadminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :superadmin, :boolean, default: false
  end
end
