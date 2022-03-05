class AddGoogleAnalyticsViewIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ga_view_id, :string
  end
end
