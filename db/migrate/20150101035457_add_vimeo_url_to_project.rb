class AddVimeoUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :vimeo_url, :string
  end
end
