class AddCreatedSessionIdToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :created_session_id, :string
  end
end
