class AddUserToProjectCategory < ActiveRecord::Migration
  def change
    add_reference :project_categories, :user, index: true, foreign_key: true
  end
end
