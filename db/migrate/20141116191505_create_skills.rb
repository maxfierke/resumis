class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.references :skill_category, index: true
      t.references :user, index: true

      t.timestamps
    end
    add_index :skills, :name, unique: true
  end
end
