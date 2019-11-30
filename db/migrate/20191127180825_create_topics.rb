class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.string :image

      t.timestamps
    end
    add_index :topics, [:user_id, :created_at]
  end
end
