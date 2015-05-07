class AddUserToSkillCategory < ActiveRecord::Migration
  def change
    add_reference :skill_categories, :user, index: true, foreign_key: true
  end
end
