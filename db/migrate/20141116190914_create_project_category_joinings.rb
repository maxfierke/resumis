class CreateProjectCategoryJoinings < ActiveRecord::Migration
  def change
    create_table :project_category_joinings do |t|
      t.references :project, index: true
      t.references :project_category, index: true

      t.timestamps
    end
  end
end
