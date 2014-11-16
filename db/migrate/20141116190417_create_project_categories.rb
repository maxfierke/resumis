class CreateProjectCategories < ActiveRecord::Migration
  def change
    create_table :project_categories do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
    add_index :project_categories, :slug, unique: true
    add_index :project_categories, :name, unique: true
  end
end
