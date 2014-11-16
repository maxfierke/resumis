class CreateResumeSkills < ActiveRecord::Migration
  def change
    create_table :resume_skills do |t|
      t.references :resume, index: true
      t.references :skill, index: true

      t.timestamps
    end
  end
end
