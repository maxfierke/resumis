class RemoveUniqueNameIndexFromSkillCategory < ActiveRecord::Migration
  def change
    remove_index :skill_categories, :name if index_exists?(:skill_categories, :name)
  end
end
