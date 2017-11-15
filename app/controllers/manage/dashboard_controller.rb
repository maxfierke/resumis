module Manage
  class DashboardController < ManageController
    def index
      skip_policy_scope
    end
  end
end
