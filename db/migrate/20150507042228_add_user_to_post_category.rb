class AddUserToPostCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :post_categories, :user, index: true, foreign_key: true
  end
end
