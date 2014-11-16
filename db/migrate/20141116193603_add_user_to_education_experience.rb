class AddUserToEducationExperience < ActiveRecord::Migration
  def change
    add_reference :education_experiences, :user, index: true
  end
end
