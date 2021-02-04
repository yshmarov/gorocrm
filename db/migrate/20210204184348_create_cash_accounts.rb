class CreateCashAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :cash_accounts do |t|
      t.string :name
      t.string :balance, default: 0, null: false

      t.timestamps
    end
  end
end
