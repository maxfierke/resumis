class ChangeScopesDefaultNotNull < ActiveRecord::Migration[6.0]
  class OAuthAccessGrants < ActiveRecord::Base
    self.table_name = 'oauth_access_grants'
  end

  def change
    OAuthAccessGrants.where(scopes: nil).find_each do |grant|
      grant.update_column(:scopes, '')
    end

    change_column_default :oauth_access_grants, :scopes, from: nil, to: ''
    change_column_null :oauth_access_grants, :scopes, false
  end
end
