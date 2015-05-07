class RemoveUniqueNameIndexFromProjectStatus < ActiveRecord::Migration
  def change
    remove_index :project_statuses, :name if index_exists?(:project_statuses, :name)
  end
end
