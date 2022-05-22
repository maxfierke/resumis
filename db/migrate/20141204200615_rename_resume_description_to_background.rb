class RenameResumeDescriptionToBackground < ActiveRecord::Migration[5.0]
  def change
    rename_column :resumes, :description, :background
  end
end
