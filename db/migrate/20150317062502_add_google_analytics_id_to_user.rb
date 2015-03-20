class AddGoogleAnalyticsIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_analytics_id, :string
  end
end
