class AddSlugToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :slug, :string
    add_index :projects, [:slug, :user_id], unique: true

    Project.unscoped.find_each do |p|
      ActsAsTenant.with_tenant(p.user) do
        p.save!
      end
    end
  end

  def down
    remove_index :projects, [:slug, :user_id]
    remove_column :projects, :slug
  end
end
