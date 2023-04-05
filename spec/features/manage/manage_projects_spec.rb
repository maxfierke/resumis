require 'rails_helper'

RSpec.describe 'Managing Projects', type: :system do
  before do
    user = FactoryBot.create(:user, :admin)
    sign_in(user, scope: :user)
    visit manage_dashboard_path
  end

  scenario 'Creating a featured project' do
    click_link('Start a Project')

    fill_in('project_name', with: 'Testing')
    fill_in('project_short_description', with: 'Testing code is good')
    fill_in('project_description', with: 'Testing code is good')
    select('Active', from: 'project_project_status_id')
    check('project_featured')
    click_button('Create Project')

    expect(page).to have_current_path(manage_projects_path)

    within('.card') do
      expect(page).to have_content('Testing')
    end
  end
end
