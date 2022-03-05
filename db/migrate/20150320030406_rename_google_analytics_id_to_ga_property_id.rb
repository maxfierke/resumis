class RenameGoogleAnalyticsIdToGaPropertyId < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :google_analytics_id, :ga_property_id
  end
end
