class AddURLToProject < ActiveRecord::Migration
  def change
    add_column :projects, :soundcloud_url, :string
  end
end
