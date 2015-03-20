class AddGoogleAnalyticsViewIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :ga_view_id, :string
  end
end
