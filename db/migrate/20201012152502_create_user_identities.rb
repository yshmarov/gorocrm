class CreateUserIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :user_identities do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :auth
    end
  end
end
