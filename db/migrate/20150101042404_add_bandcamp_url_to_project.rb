class AddBandcampUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :bandcamp_url, :string
  end
end
