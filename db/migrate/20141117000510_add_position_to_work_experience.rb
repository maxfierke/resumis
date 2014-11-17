class AddPositionToWorkExperience < ActiveRecord::Migration
  def change
    add_column :work_experiences, :position, :string
  end
end
