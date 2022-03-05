class AddPublishedOnToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :published_on, :datetime
  end
end
