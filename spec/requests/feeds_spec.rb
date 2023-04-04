require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  let!(:user) do
    FactoryBot.create(:user)
  end

  describe "GET /posts.rss", :aggregate_failures do
    it "returns an RSS feed w/ the expected posts" do
      FactoryBot.create_list(:post, 4, :with_categories, :published, user: user)
      posts = user.posts.includes(:post_categories).order(
        published_on: :desc,
        updated_at: :desc,
        created_at: :desc
      )

      get posts_feed_path(format: :rss)
      expect(response).to have_http_status(200)

      posts_rss = Nokogiri::XML(response.body)

      channel = posts_rss.xpath("//rss//channel").first
      expect(channel).not_to be_nil

      expect(channel.xpath("./title").first.content).to eq("#{user.full_name}'s Blog")
      expect(channel.xpath("./copyright").first.content).to eq("Copyright © #{Time.current.year} #{user.full_name}")
      expect(channel.xpath("./description").first.content).to eq(user.tagline)
      expect(channel.xpath("./link").first.content).to eq(user.blog_url)

      post_items = channel.xpath("./item")
      expect(post_items.size).to eq(posts.size)

      post_items.each_with_index do |post_item, index|
        post = posts[index]
        expect(post_item.xpath("./title").first.content).to eq(post.title)
        expect(post_item.xpath("./author").first.content).to eq(user.full_name)
        expect(post_item.xpath("./pubDate").first.content).to eq(post.published_on.to_fs(:rfc822))
        expect(post_item.xpath("./link").first.content).to eq("#{user.blog_url}/#{post.slug}")
        expect(post_item.xpath("./description").first.content).to include(ApplicationHelper.markdown(post.body))

        rss_categories = post_item.xpath("./category").map(&:content)

        expect(rss_categories).to match_array(post.post_categories.pluck(:name))
      end
    end

    it "only returns the latest 15" do
      FactoryBot.create_list(:post, 25, :published, user: user)

      get posts_feed_path(format: :rss)
      expect(response).to have_http_status(200)

      posts_rss = Nokogiri::XML(response.body)
      post_items = posts_rss.xpath("//rss//channel//item")
      expect(post_items.size).to eq(15)
    end

    it "only does not include unpublished posts" do
      FactoryBot.create_list(:post, 3, :published, user: user)
      FactoryBot.create_list(:post, 2, published: false, user: user)

      get posts_feed_path(format: :rss)
      expect(response).to have_http_status(200)

      posts_rss = Nokogiri::XML(response.body)
      post_items = posts_rss.xpath("//rss//channel//item")
      expect(post_items.size).to eq(3)
    end
  end

  describe "GET /posts.atom", :aggregate_failures do
    it "returns an Atom feed w/ the expected posts" do
      FactoryBot.create_list(:post, 4, :with_categories, :published, user: user)
      posts = user.posts.includes(:post_categories).order(
        published_on: :desc,
        updated_at: :desc,
        created_at: :desc
      )

      get posts_feed_path(format: :atom)
      expect(response).to have_http_status(200)

      posts_atom = Nokogiri::XML(response.body)

      feed = posts_atom.xpath("//xmlns:feed").first
      expect(feed).not_to be_nil

      expect(feed.xpath("./xmlns:title").first.content).to eq("#{user.full_name}'s Blog")
      expect(feed.xpath("./xmlns:subtitle").first.content).to eq(user.tagline)
      expect(feed.xpath("./xmlns:author/xmlns:name").first.content).to eq(user.full_name)
      expect(feed.xpath("./xmlns:rights").first.content).to eq("Copyright © #{Time.current.year} #{user.full_name}")
      expect(feed.xpath("./xmlns:link[@rel='alternate']").first["href"]).to eq(user.blog_url)

      post_items = feed.xpath("./xmlns:entry")
      expect(post_items.size).to eq(posts.size)

      post_items.each_with_index do |post_item, index|
        post = posts[index]
        expect(post_item.xpath("./xmlns:title").first.content).to eq(post.title)
        expect(post_item.xpath("./xmlns:author/xmlns:name").first.content).to eq(user.full_name)
        expect(post_item.xpath("./xmlns:published").first.content).to eq(post.published_on.iso8601)
        expect(post_item.xpath("./xmlns:updated").first.content).to eq(post.updated_at.iso8601)
        expect(post_item.xpath("./xmlns:link").first["href"]).to eq("#{user.blog_url}/#{post.slug}")
        content_node = post_item.xpath("./xmlns:content").first
        expect(content_node["type"]).to eq("html")
        expect(content_node.content).to include(ApplicationHelper.markdown(post.body))

        post.post_categories.each do |post_category|
          expect(post_item.xpath("./xmlns:category[@term='#{post_category.name}' and @label='#{post_category.name}']")).not_to be_empty
        end
      end
    end

    it "only returns the latest 15" do
      FactoryBot.create_list(:post, 25, :published, user: user)

      get posts_feed_path(format: :atom)
      expect(response).to have_http_status(200)

      posts_rss = Nokogiri::XML(response.body)
      post_items = posts_rss.xpath("//xmlns:feed//xmlns:entry")
      expect(post_items.size).to eq(15)
    end

    it "only does not include unpublished posts" do
      FactoryBot.create_list(:post, 3, :published, user: user)
      FactoryBot.create_list(:post, 2, published: false, user: user)

      get posts_feed_path(format: :atom)
      expect(response).to have_http_status(200)

      posts_rss = Nokogiri::XML(response.body)
      post_items = posts_rss.xpath("//xmlns:feed//xmlns:entry")
      expect(post_items.size).to eq(3)
    end
  end
end
