class AddDescriptionToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :description, :string
  end
end
