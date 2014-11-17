class AddDiplomaToEducationExperience < ActiveRecord::Migration
  def change
    add_column :education_experiences, :diploma, :string
  end
end
