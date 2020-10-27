class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :amount
      t.string :currency
      t.string :interval
      t.integer :max_members

      t.timestamps
    end
  end
end
