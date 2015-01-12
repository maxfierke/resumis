class AddHeaderImageURLToUser < ActiveRecord::Migration
  def change
    add_column :users, :header_image_url, :string
  end
end
