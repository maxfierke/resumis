class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :short_description
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :project_status, index: true

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
