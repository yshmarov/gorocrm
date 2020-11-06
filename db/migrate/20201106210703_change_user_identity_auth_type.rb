class ChangeUserIdentityAuthType < ActiveRecord::Migration[6.0]
  def up
    change_column :user_identities, :auth, :text
  end

  def down
    change_column :user_identities, :auth, :string
  end
end
