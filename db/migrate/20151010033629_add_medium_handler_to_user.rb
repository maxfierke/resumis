class AddMediumHandlerToUser < ActiveRecord::Migration
  def change
    add_column :users, :medium_handle, :string
  end
end
