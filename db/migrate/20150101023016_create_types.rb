class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :types, :slug, unique: true

    create_join_table :users, :types
  end
end
