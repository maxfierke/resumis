class RenameUserTypeJoinTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :types_users, :user_types
  end
end
