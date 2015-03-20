class RemoveTaglineFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :tagline
  end
end
