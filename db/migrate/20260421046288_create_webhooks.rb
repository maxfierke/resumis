class CreateWebhooks < ActiveRecord::Migration[8.0]
  def change
    create_table :webhooks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :url, null: false
      t.string :resource_types, array: true, default: [], null: false
      t.boolean :enabled, null: false, default: true
      t.string :secret, null: false
      t.timestamps
    end

    add_index :webhooks, [:user_id, :url], unique: true
  end
end
