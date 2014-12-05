class AddTaglineToUser < ActiveRecord::Migration
  def change
    add_column :users, :tagline, :string
  end
end
