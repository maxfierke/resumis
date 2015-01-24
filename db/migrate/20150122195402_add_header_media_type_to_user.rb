class AddHeaderMediaTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :header_media_type, :integer, default: 0
  end
end
