class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :post_categories, :slug, unique: true
  end
end
