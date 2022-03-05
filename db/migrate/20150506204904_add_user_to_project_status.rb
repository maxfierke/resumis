class AddUserToProjectStatus < ActiveRecord::Migration[5.0]
  def change
    add_reference :project_statuses, :user, index: true, foreign_key: true
  end
end
