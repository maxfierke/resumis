class CreateResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :resumes do |t|
      t.references :user, index: true
      t.string :name
      t.text :description
      t.boolean :published

      t.timestamps
    end
  end
end
