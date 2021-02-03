class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :tenant, null: false, foreign_key: true
      t.belongs_to :project, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.datetime :deadline
      t.boolean :urgent
      t.string :status

      t.timestamps
    end
  end
end
