class AddMetadataToCharges < ActiveRecord::Migration[6.0]
  def change
    add_column :charges, :metadata, :text
  end
end
