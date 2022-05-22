class AddDescriptionToResume < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :description, :string
  end
end
