class CreateProjectStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :project_statuses do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
    add_index :project_statuses, :slug, unique: true
    add_index :project_statuses, :name, unique: true
  end
end
