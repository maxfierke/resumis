class AddHeaderVideoToUser < ActiveRecord::Migration
  def change
    add_column :users, :header_video, :string
  end
end
