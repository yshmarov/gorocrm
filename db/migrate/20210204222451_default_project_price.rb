class DefaultProjectPrice < ActiveRecord::Migration[6.1]
  def change
    change_column_null :projects, :price, false
    change_column_default :projects, :price, 0
  end
end
