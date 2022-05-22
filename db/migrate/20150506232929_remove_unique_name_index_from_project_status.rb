class RemoveUniqueNameIndexFromProjectStatus < ActiveRecord::Migration[5.0]
  def change
    remove_index :project_statuses, :name if index_exists?(:project_statuses, :name)
  end
end
