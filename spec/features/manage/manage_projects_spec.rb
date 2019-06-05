require 'rails_helper'

feature 'Managing Projects' do
  before do
    user = FactoryBot.create(:user, :admin)
    sign_in(user, scope: :user)
    visit '/manage'
  end

  scenario 'Creating a featured project' do
    click_link('Add a New Project')

    fill_in('project_name', with: 'Testing')
    fill_in('project_short_description', with: 'Testing code is good')
    fill_in('project_description', with: 'Testing code is good')
    select('Active', from: 'project_project_status_id')
    check('project_featured')
    click_button('Create Project')

    expect(current_path).to eq('/manage/projects')

    within('.list-group-item') do
      expect(page).to have_content('Testing')
    end
  end
end
