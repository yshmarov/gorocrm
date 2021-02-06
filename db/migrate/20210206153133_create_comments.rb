class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.belongs_to :tenant, null: false, foreign_key: true
      t.text :content, null: false
      t.references :commentable, polymorphic: true, null: false
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
