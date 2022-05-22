class AddAvatarLabelToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_label, :string
  end
end
