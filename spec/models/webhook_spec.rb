require 'rails_helper'

RSpec.describe Webhook, type: :model do
  describe 'validations' do
    subject(:webhook) { FactoryBot.build(:webhook) }

    it 'is valid with valid attributes' do
      expect(webhook).to be_valid
    end

    it 'is invalid with a name' do
      webhook.name = nil
      expect(webhook).not_to be_valid
      expect(webhook.errors[:name]).to be_present
    end

    it 'is invalid without a URL' do
      webhook.url = nil
      expect(webhook).not_to be_valid
      expect(webhook.errors[:url]).to be_present
    end

    it 'is invalid with an empty resource types array' do
      webhook.resource_types = []
      expect(webhook).not_to be_valid
      expect(webhook.errors[:resource_types]).to be_present
    end

    it 'is invalid when resource types only contain blank values' do
      webhook.resource_types = ["", ""]
      expect(webhook).not_to be_valid
      expect(webhook.errors[:resource_types]).to be_present
    end

    describe '#url_scheme_allowed' do
      context 'with an HTTPS URL' do
        it 'is valid' do
          webhook.url = 'https://example.com/hook'
          expect(webhook).to be_valid
        end
      end

      context 'with an HTTP URL' do
        it 'is valid outside production' do
          webhook.url = 'http://localhost:3001/hook'
          expect(webhook).to be_valid
        end

        it 'is invalid in production' do
          webhook.url = 'http://example.com/hook'
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
          expect(webhook).not_to be_valid
          expect(webhook.errors[:url]).to include("must use HTTPS")
        end
      end

      context 'with an invalid URL' do
        it 'adds an error' do
          webhook.url = 'not a url %%'
          expect(webhook).not_to be_valid
          expect(webhook.errors[:url]).to include("is not a valid URL")
        end
      end
    end

    describe '#resource_types_are_valid' do
      it 'is valid with known resource types' do
        webhook.resource_types = %w[post project]
        expect(webhook).to be_valid
      end

      it 'is invalid with unknown resource types' do
        webhook.resource_types = %w[post unknown_type]
        expect(webhook).not_to be_valid
        expect(webhook.errors[:resource_types]).to include('is not included in the list')
      end
    end
  end

  describe 'secret generation' do
    it 'generates a secret on create' do
      webhook = FactoryBot.create(:webhook)
      expect(webhook.secret).to be_present
      expect(webhook.secret.size).to eq(64)
    end

    it 'does not overwrite an existing secret' do
      webhook = FactoryBot.build(:webhook, secret: 'oooo-super-secret-please-no-hack')
      webhook.save!
      expect(webhook.secret).to eq('oooo-super-secret-please-no-hack')
    end
  end

  describe '.enabled scope' do
    let!(:enabled_webhook)  { FactoryBot.create(:webhook) }
    let!(:disabled_webhook) { FactoryBot.create(:webhook, :disabled) }

    it 'returns only enabled webhooks' do
      expect(Webhook.enabled).to contain_exactly(enabled_webhook)
    end
  end
end
