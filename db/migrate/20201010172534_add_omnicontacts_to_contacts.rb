class AddOmnicontactsToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :source, :string
    add_column :contacts, :import_id, :string
  end
end