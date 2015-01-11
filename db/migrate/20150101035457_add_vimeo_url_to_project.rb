class AddVimeoURLToProject < ActiveRecord::Migration
  def change
    add_column :projects, :vimeo_url, :string
  end
end
