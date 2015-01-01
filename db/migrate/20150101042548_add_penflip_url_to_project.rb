class AddPenflipURLToProject < ActiveRecord::Migration
  def change
    add_column :projects, :penflip_url, :string
  end
end
