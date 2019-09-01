# Derived from https://github.com/seyhunak/twitter-bootstrap-rails/blob/25c530ce9ac0be22df9a2b161b75d73f1dc64069/app/helpers/bootstrap_flash_helper.rb
module AlertHelper
  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def render_alerts(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert alert-#{type} #{tag_class}"
      }.merge(options)


      Array(message).each do |msg|
        text = content_tag(:div, msg, tag_options)
        flash_messages << text if msg
      end
    end

    if flash_messages.any?
      contents = flash_messages.join("\n").html_safe
      content_tag(:div, contents, class: 'w-full pb-2')
    else
      nil
    end
  end
end
