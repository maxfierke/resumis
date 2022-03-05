class AddGoogleAnalyticsIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_analytics_id, :string
  end
end
