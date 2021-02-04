class AddMinutesSpentToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :duration_minutes, :integer, default: 0, null: false
  end
end
