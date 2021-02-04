class AddCounterCacheFields < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :tasks_count, :integer, null: false, default: 0
    add_column :members, :tasks_count, :integer, null: false, default: 0
    add_column :cash_accounts, :payments_count, :integer, null: false, default: 0
    add_column :members, :payments_count, :integer, null: false, default: 0
    add_column :clients, :payments_count, :integer, null: false, default: 0
    add_column :clients, :projects_count, :integer, null: false, default: 0
  end
end
