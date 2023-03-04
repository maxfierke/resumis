root_url = current_tenant.blog_url ||
  current_tenant.homepage_url ||
  "https://#{tenant_instance_hostname(current_tenant)}"

atom_feed(root_url: root_url) do |feed|
  feed.title "#{current_tenant.full_name}'s Blog"
  feed.subtitle current_tenant.tagline
  feed.author do |author|
    author.name current_tenant.full_name
  end
  feed.updated(@posts.first.updated_at)
  feed.rights "Copyright © #{current_tenant.copyright_range}"

  @posts.each do |post|
    feed.entry(post, url: "#{root_url}/#{post.slug}", published: post.published_on) do |entry|
      entry.title post.title
      entry.author do |author|
        author.name post.user.full_name
      end
      entry.content(markdown(post.body), type: "html")

      post.post_categories.each do |category|
        entry.category(term: category.name, label: category.name)
      end
    end
  end
end
