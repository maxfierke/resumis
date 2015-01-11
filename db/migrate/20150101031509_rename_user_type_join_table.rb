class RenameUserTypeJoinTable < ActiveRecord::Migration
  def change
    rename_table :types_users, :user_types
  end
end
