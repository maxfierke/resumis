class AddHeaderMediaTypeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :header_media_type, :integer, default: 0
  end
end
