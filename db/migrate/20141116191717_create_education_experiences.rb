class CreateEducationExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :education_experiences do |t|
      t.string :school_name
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
