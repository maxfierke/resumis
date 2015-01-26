module Manage
  class ManageController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_tenant_session!

    layout "manage"
  end
end
