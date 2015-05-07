class RemoveUniqueSlugIndexFromProjectStatus < ActiveRecord::Migration
  def change
    remove_index :project_statuses, :slug if index_exists?(:project_statuses, :slug)
  end
end
