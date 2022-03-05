class RemoveHeaderImageUrlFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :header_image_url, :string
  end
end
