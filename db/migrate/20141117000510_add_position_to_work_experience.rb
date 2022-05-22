class AddPositionToWorkExperience < ActiveRecord::Migration[5.0]
  def change
    add_column :work_experiences, :position, :string
  end
end
