class RemoveHeaderImageURLFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :header_image_url, :string
  end
end
