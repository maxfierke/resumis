require 'rails_helper'

RSpec.describe User, type: :model do
  def stub_tenancy_mode(mode)
    allow(ResumisConfig).to receive(:tenancy_mode).and_return(mode)
  end

  it 'has a valid factory' do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it 'is invalid without a first_name' do
    expect(FactoryBot.build(:user, first_name: nil)).not_to be_valid
  end

  it 'is invalid without a last_name' do
    expect(FactoryBot.build(:user, last_name: nil)).not_to be_valid
  end

  context 'in multi-tenancy mode' do
    before { stub_tenancy_mode(:multi) }

    it 'is invalid without a subdomain' do
      expect(ResumisConfig.tenancy_mode).to eq(:multi)
      expect(FactoryBot.build(:user, subdomain: nil)).not_to be_valid
    end

    it 'needs a unique subdomain' do
      expect(ResumisConfig.tenancy_mode).to eq(:multi)
      first_user = FactoryBot.create(:user)

      expect(FactoryBot.build(:user, subdomain: first_user.subdomain)).not_to be_valid
    end
  end

  context 'in single-tenancy mode' do
    before { stub_tenancy_mode(:single) }

    it 'is valid without a subdomain' do
      expect(ResumisConfig.tenancy_mode).to eq(:single)
      expect(FactoryBot.build(:user, subdomain: nil)).to be_valid
    end
  end

  it 'can not use a reserved subdomain as its subdomain' do
    expect(FactoryBot.build(:user, subdomain: 'accounts')).not_to be_valid
  end

  it 'returns a full_name as a concat. of first_name and last_name' do
    user = FactoryBot.create(:user)

    expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
  end

  describe '#copyright_range' do
    it 'returns only the current year if only one year has spanned since creation' do
      user = FactoryBot.create(:user, created_at: DateTime.now)

      expect(user.copyright_range).to eq("#{DateTime.now.year} #{user.full_name}")
    end

    it 'returns the full span of years if more than a year old' do
      user = FactoryBot.create(:user, created_at: DateTime.new(2001,2,3))

      expect(user.copyright_range).to eq("2001-#{DateTime.now.year} #{user.full_name}")
    end
  end

  describe "#mastodon_url" do
    it "returns the expected shortcut URL" do
      user = FactoryBot.build(:user, mastodon_handle: "@lol@masto.host")

      expect(user.mastodon_url).to eq("https://masto.host/@lol")
    end
  end

  describe "#avatar_url" do
    let(:user) { FactoryBot.create(:user) }

    context "avatar is not set" do
      let(:gravatar_hash) { Digest::MD5.hexdigest(user.email) }

      it "returns a gravatar URL for a medium-sized image" do
        expect(user.avatar_url).to eq(
          "https://www.gravatar.com/avatar/#{gravatar_hash}?s=256"
        )
      end

      context "size is specified" do
        it "returns a gravatar URL instead" do
          expect(user.avatar_url(size: :small)).to eq(
            "https://www.gravatar.com/avatar/#{gravatar_hash}?s=100"
          )
        end
      end
    end

    context "avatar is set" do
      before do
        user.avatar_image.attach(
          io: File.open("#{Rails.root}/spec/fixtures/worm_drive.jpg"),
          filename: 'avatar.jpg'
        )
        user.save!
      end

      it "returns a URL to the medium-sized variant" do
        variant_name = ImageVariants.variant_name_for_image(
          user.avatar_image, size: :medium
        )
        blob = user.avatar_image.variant(variant_name).processed

        expect(user.avatar_url).to eq(
          Rails.application.routes.url_helpers.cdn_blob_url(blob)
        )
      end

      context "avatar image variant hasn't processed yet" do
        let(:gravatar_hash) { Digest::MD5.hexdigest(user.email) }

        before do
          allow(ProfileImageVariantGeneratorJob).to receive(:perform_later)
        end

        it "returns a gravatar URL instead" do
          variant_name = ImageVariants.variant_name_for_image(
            user.avatar_image, size: :medium
          )

          # Note, not calling #processed
          variant = user.avatar_image.variant(variant_name)

          expect(variant.key).to be_nil
          expect(user.avatar_url).to eq(
            "https://www.gravatar.com/avatar/#{gravatar_hash}?s=256"
          )
        end

        it "enqueues job to process variants" do
          user.avatar_url

          expect(ProfileImageVariantGeneratorJob).to have_received(:perform_later).with(user.id)
        end
      end

      context "size is specified" do
        let(:size) { :small }

        it "returns a URL to the relevant-sized variant" do
          variant_name = ImageVariants.variant_name_for_image(
            user.avatar_image, size: size
          )
          blob = user.avatar_image.variant(variant_name).processed

          expect(user.avatar_url(size: size)).to eq(
            Rails.application.routes.url_helpers.cdn_blob_url(blob)
          )
        end
      end

      context "quality is specified" do
        let(:quality) { :lossless }

        it "returns a URL to the relevant-sized variant" do
          variant_name = ImageVariants.variant_name_for_image(
            user.avatar_image, quality: quality
          )
          blob = user.avatar_image.variant(variant_name).processed

          expect(user.avatar_url(quality: quality)).to eq(
            Rails.application.routes.url_helpers.cdn_blob_url(blob)
          )
        end
      end
    end
  end

  describe "#header_image_url" do
    let(:user) { FactoryBot.create(:user) }

    context "header image is not set" do
      it "returns nil" do
        expect(user.header_image_url).to be_nil
      end
    end

    context "header image is set" do
      before do
        user.header_image.attach(
          io: File.open("#{Rails.root}/spec/fixtures/worm_drive.jpg"),
          filename: 'header_image.jpg'
        )
        user.save!
      end

      it "returns a URL to the medium-sized variant" do
        variant_name = ImageVariants.variant_name_for_image(
          user.header_image, size: :medium
        )
        blob = user.header_image.variant(variant_name).processed

        expect(user.header_image_url).to eq(
          Rails.application.routes.url_helpers.cdn_blob_url(blob)
        )
      end

      context "header image variant hasn't processed yet" do
        before do
          allow(ProfileImageVariantGeneratorJob).to receive(:perform_later)
        end

        it "returns nil" do
          variant_name = ImageVariants.variant_name_for_image(
            user.header_image, size: :medium
          )

          # Note, not calling #processed
          blob = user.header_image.variant(variant_name)

          expect(user.header_image_url).to be_nil
        end

        it "enqueues job to process variants" do
          user.header_image_url

          expect(ProfileImageVariantGeneratorJob).to have_received(:perform_later).with(user.id)
        end
      end

      context "size is specified" do
        let(:size) { :small }

        it "returns a URL to the relevant-sized variant" do
          variant_name = ImageVariants.variant_name_for_image(
            user.header_image, size: size
          )
          blob = user.header_image.variant(variant_name).processed

          expect(user.header_image_url(size: size)).to eq(
            Rails.application.routes.url_helpers.cdn_blob_url(blob)
          )
        end
      end

      context "quality is specified" do
        let(:quality) { :lossless }

        it "returns a URL to the relevant-quality variant" do
          variant_name = ImageVariants.variant_name_for_image(
            user.header_image, quality: quality
          )
          blob = user.header_image.variant(variant_name).processed

          expect(user.header_image_url(quality: quality)).to eq(
            Rails.application.routes.url_helpers.cdn_blob_url(blob)
          )
        end
      end
    end
  end
end
