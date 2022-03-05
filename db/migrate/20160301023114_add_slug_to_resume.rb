class AddSlugToResume < ActiveRecord::Migration[5.0]
  def up
    add_column :resumes, :slug, :string
    add_index :resumes, [:slug, :user_id], unique: true

    Resume.unscoped.find_each(&:save!)
  end

  def down
    remove_index :resumes, [:slug, :user_id]
    remove_column :resumes, :slug
  end
end
