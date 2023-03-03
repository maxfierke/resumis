xml.instruct! :xml, version: "1.0", encoding: "utf-8"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "#{current_tenant.full_name}'s Blog"
    xml.description current_tenant.tagline
    xml.generator "Resumis"
    xml.copyright "Copyright © #{current_tenant.copyright_range}"
    xml.link current_tenant.blog_url || current_tenant.homepage_url || "https://#{tenant_instance_hostname(current_tenant)}"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.author post.user.full_name
        xml.pubDate post.published_on.to_fs(:rfc822) if post.published_on
        xml.link "#{current_tenant.blog_url}/#{post.slug}" if current_tenant.blog_url
        xml.description { xml.cdata! markdown(post.body) }

        post.post_categories.each do |category|
          xml.category category.name
        end
      end
    end
  end
end
