class AddSoundCloudHandleToUser < ActiveRecord::Migration
  def change
    add_column :users, :soundcloud_handle, :string
  end
end
