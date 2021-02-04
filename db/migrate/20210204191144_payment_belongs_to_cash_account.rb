class PaymentBelongsToCashAccount < ActiveRecord::Migration[6.1]
  def change
    add_reference :payments, :cash_account, foreign_key: true, null: false
  end
end
