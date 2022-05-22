class DropUserTypes < ActiveRecord::Migration[5.0]
  def up
    drop_table :user_types
    drop_table :types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
