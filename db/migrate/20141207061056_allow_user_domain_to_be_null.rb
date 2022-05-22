class AllowUserDomainToBeNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :domain, true
  end
end
