class AddHeaderImageUrlToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :header_image_url, :string
  end
end
