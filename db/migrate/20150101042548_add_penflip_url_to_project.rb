class AddPenflipUrlToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :penflip_url, :string
  end
end
