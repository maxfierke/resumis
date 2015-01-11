class AddBandcampURLToProject < ActiveRecord::Migration
  def change
    add_column :projects, :bandcamp_url, :string
  end
end
