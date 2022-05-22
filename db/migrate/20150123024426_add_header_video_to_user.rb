class AddHeaderVideoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :header_video, :string
  end
end
