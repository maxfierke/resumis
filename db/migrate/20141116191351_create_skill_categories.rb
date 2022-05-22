class CreateSkillCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :skill_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :skill_categories, :name, unique: true
  end
end
