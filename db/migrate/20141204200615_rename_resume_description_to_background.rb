class RenameResumeDescriptionToBackground < ActiveRecord::Migration
  def change
    rename_column :resumes, :description, :background
  end
end
