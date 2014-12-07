require 'redcarpet'

module ApplicationHelper
  def page_title(text)
    # sets :title content_for in <head>, and outputs an h1 with the title
    content_for :title, text
    return content_tag :h1, text
  end

  def markdown(content)
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    parser = Redcarpet::Markdown.new(renderer, strikethrough: true, underline: true)
    parser.render(content).html_safe
  end

  def exists_published_resume?
    Resume.exists?(published: true)
  end

  def path_to_latest_resume
    latest_resume = Resume.where(published: true).order(updated_at: :desc).first

    return resume_path(latest_resume)
  end
end
