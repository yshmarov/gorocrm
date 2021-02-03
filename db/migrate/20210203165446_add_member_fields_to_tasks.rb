class AddMemberFieldsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :member, foreign_key: true
    add_column :tasks, :creator_id, :integer, null: false
    add_index :tasks, :creator_id
  end
end
