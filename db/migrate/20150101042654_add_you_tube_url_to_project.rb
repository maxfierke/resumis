class AddYouTubeUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :youtube_url, :string
  end
end
