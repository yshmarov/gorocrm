class AddSlugToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :slug, :string
    add_index :members, :slug, unique: true
  end
end
