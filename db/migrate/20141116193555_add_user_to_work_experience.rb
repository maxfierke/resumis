class AddUserToWorkExperience < ActiveRecord::Migration[5.0]
  def change
    add_reference :work_experiences, :user, index: true
  end
end
