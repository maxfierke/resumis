class DropUserTypes < ActiveRecord::Migration
  def up
    drop_table :user_types
    drop_table :types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
