class CreateCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :charges do |t|
      t.belongs_to :tenant, null: false, foreign_key: true
      t.belongs_to :subscription, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
