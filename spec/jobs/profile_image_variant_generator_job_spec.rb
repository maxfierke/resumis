require 'rails_helper'

RSpec.describe ProfileImageVariantGeneratorJob, type: :job do
  let(:user) { FactoryBot.create(:user) }

  it 'should generate all variants for avatar' do
    user.avatar_image.attach(
      io: File.open("#{Rails.root}/spec/fixtures/worm_drive.jpg"),
      filename: 'avatar.jpg'
    )
    user.save!

    ProfileImageVariantGeneratorJob.perform_now(user.id)

    ImageVariants.variants_for_style(:square).each do |name, _opts|
      variant = user.avatar_image.variant(name)
      expect(variant.send(:processed?)).to eq(true)
    end
  end

  it 'should generate all variants for header image' do
    user.header_image.attach(
      io: File.open("#{Rails.root}/spec/fixtures/worm_drive.jpg"),
      filename: 'header_image.jpg'
    )
    user.save!

    ProfileImageVariantGeneratorJob.perform_now(user.id)

    ImageVariants.variants_for_style(:header).each do |name, _opts|
      variant = user.header_image.variant(name)
      expect(variant.send(:processed?)).to eq(true)
    end
  end
end
