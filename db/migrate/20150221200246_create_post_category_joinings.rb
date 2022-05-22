class CreatePostCategoryJoinings < ActiveRecord::Migration[5.0]
  def change
    create_table :post_category_joinings do |t|
      t.references :post, index: true
      t.references :post_category, index: true

      t.timestamps null: false
    end
    add_foreign_key :post_category_joinings, :posts
    add_foreign_key :post_category_joinings, :post_categories
  end
end
