class RemoveUniqueNameAndSlugIndicesFromPostCategory < ActiveRecord::Migration
  def change
    remove_index :post_categories, :name if index_exists?(:post_categories, :name)
    remove_index :post_categories, :slug if index_exists?(:post_categories, :slug)
  end
end
