module ApplicationHelper
  def page_title(text, tag_type = :h1, tag_attributes = {}, prepend_name = true)
    content_for :title, text
    content_tag tag_type, text, tag_attributes
  end

  def icon(style, name, text = nil, html_options = {})
    # Ripped from https://github.com/FortAwesome/font-awesome-sass/blob/8f5c2f742b6d8bc25a3b3db4ff2287f2b0332fe8/lib/font_awesome/sass/rails/helpers.rb
    text, html_options = nil, text if text.is_a?(Hash)

    content_class = "#{style} fa-#{name}"
    content_class << " #{html_options[:class]}" if html_options.key?(:class)
    html_options[:class] = content_class

    html = content_tag(:i, nil, html_options)
    html << ' ' << text.to_s unless text.blank?
    html
  end

  def markdown(content)
    return nil unless content
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true,
      no_styles: true,
      safe_links_only: true
    )
    parser = Redcarpet::Markdown.new(renderer, strikethrough: true, underline: true, fenced_code_blocks: true)
    parser.render(content).html_safe
  end

  def tenant_instance_hostname(tenant, domains_allowed = true)
    if ResumisConfig.multi_tenant?
      return tenant.domain if tenant.domain && domains_allowed
      "#{tenant.subdomain}.#{request.domain}"
    else
      ResumisConfig.canonical_host
    end
  end
end
