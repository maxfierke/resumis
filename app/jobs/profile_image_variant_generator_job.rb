class ProfileImageVariantGeneratorJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    if user.avatar_image&.attached? && user.avatar_image&.image?
      ImageVariants.variants_for_style(:square).each do |name, _opts|
        variant = user.avatar_image.variant(name)
        Rails.logger.info "Processed avatar variant #{name} for #{user.id}" if variant.processed
      end
    end

    if user.header_image&.attached? && user.header_image&.image?
      ImageVariants.variants_for_style(:header).each do |name, _opts|
        variant = user.header_image.variant(name)
        Rails.logger.info "Processed header image variant #{name} for #{user.id}" if variant.processed
      end
    end
  end
end
