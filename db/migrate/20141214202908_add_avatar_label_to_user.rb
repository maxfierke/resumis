class AddAvatarLabelToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_label, :string
  end
end
