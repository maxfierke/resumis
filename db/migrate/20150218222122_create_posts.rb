class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :tagline
      t.text :body
      t.boolean :published
      t.references :user, index: true
      t.string :slug
      t.timestamps null: false
    end
    add_foreign_key :posts, :users
    add_index :posts, :slug, unique: true
  end
end
