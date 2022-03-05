class RemoveTaglineFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :tagline
  end
end
