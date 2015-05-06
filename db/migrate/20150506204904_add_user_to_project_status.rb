class AddUserToProjectStatus < ActiveRecord::Migration
  def change
    add_reference :project_statuses, :user, index: true, foreign_key: true
  end
end
