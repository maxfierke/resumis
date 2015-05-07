class AddUserToPostCategory < ActiveRecord::Migration
  def change
    add_reference :post_categories, :user, index: true, foreign_key: true
  end
end
