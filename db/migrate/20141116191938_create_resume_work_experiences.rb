class CreateResumeWorkExperiences < ActiveRecord::Migration
  def change
    create_table :resume_work_experiences do |t|
      t.references :resume, index: true
      t.references :work_experience, index: true

      t.timestamps
    end
  end
end
