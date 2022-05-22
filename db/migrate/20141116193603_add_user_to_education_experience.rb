class AddUserToEducationExperience < ActiveRecord::Migration[5.0]
  def change
    add_reference :education_experiences, :user, index: true
  end
end
