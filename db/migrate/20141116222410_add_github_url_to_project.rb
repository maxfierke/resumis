class AddGithubUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :github_url, :string
  end
end
