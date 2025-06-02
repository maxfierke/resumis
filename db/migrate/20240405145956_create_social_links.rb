class CreateSocialLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :social_links do |t|
      t.string :network, null: false
      t.string :username
      t.string :url
      t.references :user, null: false

      t.timestamps
    end

    add_index :social_links, [:network, :username, :user_id], unique: true
  end
end
