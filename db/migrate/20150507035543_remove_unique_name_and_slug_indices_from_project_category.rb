class RemoveUniqueNameAndSlugIndicesFromProjectCategory < ActiveRecord::Migration
  def change
    remove_index :project_categories, :name if index_exists?(:project_categories, :name)
    remove_index :project_categories, :slug if index_exists?(:project_categories, :slug)
  end
end
