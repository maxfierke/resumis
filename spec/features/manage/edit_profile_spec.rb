require 'rails_helper'

RSpec.describe 'Managing Profile', type: :system do
  include ActionView::Helpers::DateHelper

  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in(user, scope: :user)
    visit manage_edit_profile_path
  end


  scenario 'Adding social links', js: true do
    expect(page).to have_current_path(manage_edit_profile_path)

    click_link("Add social network", href: nil)

    within('.js-add-edit-social-link:last-of-type') do
      select('Tiktok')
      fill_in(with: 'mycoolaccount123', placeholder: 'username/handle')
    end

    within('.actionbar') do
      click_button('Save Changes')
    end

    expect(page).to have_current_path(manage_dashboard_path)
    expect(page).to have_content("Your profile was successfully updated.")

    social_links = user.reload.social_links
    tiktok = social_links.find { |link| link.network == 'tiktok' }
    expect(tiktok).not_to be_nil
    expect(tiktok.username).to eq('mycoolaccount123')

    visit manage_edit_profile_path
    expect(page).to have_current_path(manage_edit_profile_path)

    within('.js-add-edit-social-link:first-of-type') do
      expect(page).to have_css('.social-link-icon-tiktok')
      expect(page).to have_field("TikTok", with: "mycoolaccount123")
    end
  end
end
