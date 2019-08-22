module ApplicationHelper
  def page_title(text, tag_type = :h1, tag_attributes = {}, prepend_name = true)
    content_for :title, text
    content_tag tag_type, text, tag_attributes
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
