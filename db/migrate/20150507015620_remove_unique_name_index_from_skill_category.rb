class RemoveUniqueNameIndexFromSkillCategory < ActiveRecord::Migration[5.0]
  def change
    remove_index :skill_categories, :name if index_exists?(:skill_categories, :name)
  end
end
