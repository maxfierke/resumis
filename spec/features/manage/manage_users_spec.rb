require 'rails_helper'

feature 'Managing Users' do
  let!(:admin_user) { FactoryBot.create(:user, :admin) }
  let!(:random_user) { FactoryBot.create(:user) }
  let!(:troublesome_user) { FactoryBot.create(:user) }
  let!(:forgetful_user) { FactoryBot.create(:user, locked_at: 3.days.ago) }
  let!(:vindicated_user) { FactoryBot.create(:user, disabled_at: 3.days.ago) }

  before do
    allow(ResumisConfig).to receive(:multi_tenant?).and_return(true)
    sign_in(admin_user, scope: :user)
    visit manage_users_path
  end

  scenario 'does show a link to manage users in the sidebar' do
    within('[data-test-key="nav-admin-dropdown"]') do
      expect(page).to have_content('Users')
    end
  end

  context "single-tenant mode" do
    before do
      allow(ResumisConfig).to receive(:multi_tenant?).and_return(false)
      visit manage_dashboard_path
    end

    scenario 'does not show a link to manage users' do
      within('[data-test-key="nav-admin-dropdown"]') do
        expect(page).not_to have_content('Users')
      end
    end
  end

  scenario 'Editing a user' do
    click_link(random_user.email)
    expect(page).to have_current_path("/manage/users/#{random_user.id}/edit")

    fill_in('user_first_name', with: 'Bilbo')
    fill_in('user_last_name', with: 'Bagginsworth')
    fill_in('user_subdomain', with: 'bilbo')
    fill_in('user_domain', with: 'bagginsworth.test')
    click_button('Update User')

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content('Bilbo Bagginsworth successfully updated.')

    within("tr[data-user-id='#{random_user.id}']") do
      expect(page).to have_content('Bilbo Bagginsworth')
      expect(page).to have_content('bilbo')
      expect(page).to have_content('bagginsworth.test')
      expect(page).to have_content('Active')
    end
  end

  scenario 'Unlocking a user' do
    click_link(forgetful_user.email)
    expect(page).to have_current_path("/manage/users/#{forgetful_user.id}/edit")

    click_button('Unlock')

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content("#{forgetful_user.full_name} was unlocked successfully.")

    within("tr[data-user-id='#{forgetful_user.id}']") do
      expect(page).to have_content('Active')
    end
  end

  scenario 'Disabling a user' do
    click_link(troublesome_user.email)
    expect(page).to have_current_path("/manage/users/#{troublesome_user.id}/edit")

    click_button('Disable')

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content("#{troublesome_user.full_name} was disabled successfully.")

    within("tr[data-user-id='#{troublesome_user.id}']") do
      expect(page).to have_content('Disabled')
    end
  end

  scenario 'Re-enabling a user' do
    click_link(vindicated_user.email)
    expect(page).to have_current_path("/manage/users/#{vindicated_user.id}/edit")

    click_button('Enable')

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content("#{vindicated_user.full_name} was enabled successfully.")

    within("tr[data-user-id='#{vindicated_user.id}']") do
      expect(page).to have_content('Active')
    end
  end

  scenario 'Deleting a user' do
    within("tr[data-user-id='#{troublesome_user.id}']") do
      click_link('Delete')
    end

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content("#{troublesome_user.full_name} successfully destroyed.")

    within('table') do
      expect(page).not_to have_content(troublesome_user.full_name)
    end
  end
end
