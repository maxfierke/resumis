class AddUserToWorkExperience < ActiveRecord::Migration
  def change
    add_reference :work_experiences, :user, index: true
  end
end
