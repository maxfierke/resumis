class RemoveGooglePlusHandleFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :googleplus_handle
  end
end
