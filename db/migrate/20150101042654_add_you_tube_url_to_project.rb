class AddYouTubeURLToProject < ActiveRecord::Migration
  def change
    add_column :projects, :youtube_url, :string
  end
end
