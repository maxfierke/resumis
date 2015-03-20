class RenameGoogleAnalyticsIdToGaPropertyId < ActiveRecord::Migration
  def change
    rename_column :users, :google_analytics_id, :ga_property_id
  end
end
