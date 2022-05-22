class AddUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :soundcloud_url, :string
  end
end
