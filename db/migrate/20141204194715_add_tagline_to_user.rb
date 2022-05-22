class AddTaglineToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tagline, :string
  end
end
