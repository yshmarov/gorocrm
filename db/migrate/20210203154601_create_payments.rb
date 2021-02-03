class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.belongs_to :tenant, null: false, foreign_key: true
      t.references :payable, polymorphic: true, null: false
      t.integer :amount
      t.text :description

      t.timestamps
    end
  end
end
