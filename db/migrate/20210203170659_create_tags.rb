class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
