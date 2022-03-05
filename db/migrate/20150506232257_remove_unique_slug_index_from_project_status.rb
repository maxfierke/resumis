class RemoveUniqueSlugIndexFromProjectStatus < ActiveRecord::Migration[5.0]
  def change
    remove_index :project_statuses, :slug if index_exists?(:project_statuses, :slug)
  end
end
