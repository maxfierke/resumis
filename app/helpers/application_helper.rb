require 'redcarpet'

module ApplicationHelper
  def page_title(text, tag_type = :h1, tag_attributes = {})
    # sets :title content_for in <head>, and outputs an h1 with the title
    if current_tenant
      content_for :title, "#{current_tenant.full_name} - #{text}"
    else
      content_for :title, text
    end

    return content_tag tag_type, text, tag_attributes
  end

  def markdown(content)
    return nil unless content
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    parser = Redcarpet::Markdown.new(renderer, strikethrough: true, underline: true)
    parser.render(content).html_safe
  end

  def exists_published_resume?
    Resume.exists?(published: true)
  end

  def tenant_instance_hostname(tenant)
    if multi_tenancy?
      return tenant.domain if tenant.domain
      "#{tenant.subdomain}.#{request.domain}"
    else
      canonical_host
    end
  end
end
