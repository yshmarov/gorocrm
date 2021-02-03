class ChangeTaskDefaultStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :status, false
    change_column_default :tasks, :status, "planned"
  end
end
