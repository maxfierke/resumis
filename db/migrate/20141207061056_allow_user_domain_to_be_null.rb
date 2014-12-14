class AllowUserDomainToBeNull < ActiveRecord::Migration
  def change
    change_column_null :users, :domain, true
  end
end
