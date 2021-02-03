class ClientBelongsToTenant < ActiveRecord::Migration[6.1]
  def change
    add_reference :clients, :tenant, foreign_key: true, null: false
  end
end
