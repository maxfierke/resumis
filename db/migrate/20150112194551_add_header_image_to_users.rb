class AddHeaderImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :header_image, :string
  end
end
