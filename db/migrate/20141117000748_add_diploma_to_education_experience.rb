class AddDiplomaToEducationExperience < ActiveRecord::Migration[5.0]
  def change
    add_column :education_experiences, :diploma, :string
  end
end
