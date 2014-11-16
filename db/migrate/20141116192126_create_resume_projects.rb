class CreateResumeProjects < ActiveRecord::Migration
  def change
    create_table :resume_projects do |t|
      t.references :resume, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
