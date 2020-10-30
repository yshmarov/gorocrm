class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true, index: { unique: true }
      t.datetime :ends_at

      t.timestamps
    end
  end
end
