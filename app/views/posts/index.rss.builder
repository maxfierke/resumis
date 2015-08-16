xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{current_tenant.full_name}'s Blog"
    xml.author current_tenant.full_name
    xml.description ""
    xml.link blog_url
    xml.language "en"

    for post in @posts
      xml.item do
        xml.title post.title
        xml.author post.user.full_name
        xml.pubDate post.published_on.to_s(:rfc822) if post.published_on
        xml.link post_url(post)
        xml.guid post.id
        xml.description { xml.cdata! markdown(post.body) }
      end
    end
  end
end
