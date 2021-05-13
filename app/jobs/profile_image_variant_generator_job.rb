class ProfileImageVariantGeneratorJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    if user.avatar_image&.attached?
      User::AVATAR_IMAGE_VARIANTS.each do |name, variant_config|
        variant = user.avatar_image.variant(**variant_config)
        was_processed = variant.processed
        Rails.logger.info "Processed avatar variant #{name} for #{user.id}" if was_processed
      end
    end

    if user.header_image&.attached?
      User::HEADER_IMAGE_VARIANTS.each do |name, variant_config|
        variant = user.header_image.variant(**variant_config)
        was_processed = variant.processed
        Rails.logger.info "Processed header image variant #{name} for #{user.id}" if was_processed
      end
    end
  end
end
