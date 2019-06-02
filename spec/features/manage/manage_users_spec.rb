require 'rails_helper'

feature 'Managing Users' do
  let!(:admin_user) { FactoryBot.create(:user, :admin) }
  let!(:random_user) { FactoryBot.create(:user) }
  let!(:troublesome_user) { FactoryBot.create(:user) }
  let!(:vindicated_user) { FactoryBot.create(:user, locked_at: 3.days.ago) }

  before do
    login_as(admin_user, scope: :user)
    visit manage_users_path
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

  scenario 'Locking a user' do
    click_link(troublesome_user.email)
    expect(page).to have_current_path("/manage/users/#{troublesome_user.id}/edit")

    click_button('Lock')

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content("#{troublesome_user.full_name} was locked successfully.")

    within("tr[data-user-id='#{troublesome_user.id}']") do
      expect(page).to have_content('Locked')
    end
  end

  scenario 'Unlocking a user' do
    click_link(vindicated_user.email)
    expect(page).to have_current_path("/manage/users/#{vindicated_user.id}/edit")

    click_button('Unlock')

    expect(page).to have_current_path('/manage/users')
    expect(page).to have_content("#{vindicated_user.full_name} was unlocked successfully.")

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
