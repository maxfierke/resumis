class AddUserToProjectCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :project_categories, :user, index: true, foreign_key: true
  end
end
