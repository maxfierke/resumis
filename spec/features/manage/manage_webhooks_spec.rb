require 'rails_helper'

RSpec.describe 'Managing Webhooks', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in(user, scope: :user)
    visit manage_webhooks_path
  end

  scenario 'Listing webhooks' do
    enabled_webhook = FactoryBot.create(:webhook, user: user, url: 'https://example.com/hooks/deploy')
    disabled_webhook = FactoryBot.create(:webhook, :disabled, user: user, url: 'https://example.com/hooks/notify')
    visit manage_webhooks_path

    [enabled_webhook, disabled_webhook].each do |webhook|
      within("article", text: webhook.name) do
        expect(page).to have_content(webhook.name)
        expect(page).to have_content(webhook.url)

        webhook.resource_types.each do |type|
          expect(page).to have_content(type)
        end
      end
    end

    within("article", text: enabled_webhook.name) do
      expect(page).to have_content('Enabled')
    end

    within("article", text: disabled_webhook.name) do
      expect(page).to have_content('Disabled')
    end

    expect(page).to have_link('New Webhook')
  end

  scenario 'Creating a webhook' do
    click_link('New Webhook')

    fill_in('webhook_name', with: 'Deploy Hook')
    fill_in('webhook_url', with: 'https://example.com/hooks/deploy')
    check('webhook_resource_types_post')
    check('webhook_enabled')
    click_button('Create Webhook')

    expect(page).to have_current_path(manage_webhooks_path)
    expect(page).to have_content('Webhook was successfully created.')
    expect(page).to have_content('Deploy Hook')
  end

  scenario 'Creating a webhook with invalid data' do
    click_link('New Webhook')
    click_button('Create Webhook')

    expect(page).to have_css('.alert-danger')
    expect(page).to have_content("can't be blank")
  end

  scenario 'Editing a webhook' do
    webhook = FactoryBot.create(:webhook, user: user)
    visit manage_webhooks_path

    click_link(webhook.name)

    expect(page).to have_current_path(edit_manage_webhook_path(webhook))
    expect(page).to have_css('input[readonly]')

    fill_in('webhook_name', with: 'EDITED: Deploy Hook')
    uncheck('webhook_resource_types_post')
    check('webhook_resource_types_resume')
    click_button('Update Webhook')

    expect(page).to have_current_path(manage_webhooks_path)
    expect(page).to have_content('Webhook was successfully updated.')
    expect(page).to have_content('EDITED: Deploy Hook')
  end

  scenario 'Disabling an enabled webhook' do
    webhook = FactoryBot.create(:webhook, user: user)
    visit edit_manage_webhook_path(webhook)

    uncheck('webhook_enabled')
    click_button('Update Webhook')

    expect(page).to have_current_path(manage_webhooks_path)
    expect(page).to have_content('Webhook was successfully updated.')

    within("article", text: webhook.name) do
      expect(page).to have_content('Disabled')
      expect(page).not_to have_content('Enabled')
    end
  end

  scenario 'Deleting a webhook from the edit page' do
    webhook = FactoryBot.create(:webhook, user: user)
    visit edit_manage_webhook_path(webhook)

    click_link('Delete')

    expect(page).to have_current_path(manage_webhooks_path)
    expect(page).to have_content('Webhook was successfully destroyed.')
    expect(page).not_to have_content(webhook.name)
    expect { webhook.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario 'Deleting a webhook from the index page' do
    webhook = FactoryBot.create(:webhook, user: user)
    visit manage_webhooks_path

    within("article", text: webhook.name) do
      click_link('Delete')
    end

    expect(page).to have_content('Webhook was successfully destroyed.')
    expect(page).not_to have_content(webhook.name)
  end
end
