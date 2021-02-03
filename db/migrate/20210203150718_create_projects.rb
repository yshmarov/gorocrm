class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.belongs_to :tenant, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.belongs_to :client, null: false, foreign_key: true
      t.string :payment_type
      t.integer :price

      t.timestamps
    end
  end
end
