class AddMediumHandlerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :medium_handle, :string
  end
end
