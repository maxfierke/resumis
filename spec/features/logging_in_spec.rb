require 'rails_helper'

RSpec.describe 'Logging in', type: :system do
  context 'admin user' do
    let!(:admin_user) { FactoryBot.create(:user, :admin) }

    before do
      sign_in(admin_user, scope: :user)
      visit manage_dashboard_path
    end

    scenario 'can login and see stuff' do
      expect(page).to have_content('Start a Project')
    end
  end

  context 'average user' do
    let!(:random_user) { FactoryBot.create(:user) }

    before do
      sign_in(random_user, scope: :user)
      visit manage_dashboard_path
    end

    scenario 'can login and see stuff' do
      expect(page).to have_content('Start a Project')
    end
  end

  context 'locked out user' do
    let!(:forgetful_user) { FactoryBot.create(:user, locked_at: 20.minutes.ago) }

    before do
      sign_in(forgetful_user, scope: :user)
      visit manage_dashboard_path
    end

    scenario 'cannot login' do
      expect(page).to have_content('Your account is locked.')
    end
  end

  context 'disabled user' do
    let!(:disabled_user) { FactoryBot.create(:user, disabled_at: 3.days.ago) }

    before do
      sign_in(disabled_user, scope: :user)
      visit manage_dashboard_path
    end

    scenario 'cannot login' do
      expect(page).to have_content('Your account is disabled.')
    end
  end
end
