require 'rails_helper'

RSpec.describe 'Managing Posts', type: :system do
  include ActionView::Helpers::DateHelper

  let!(:user) { FactoryBot.create(:user) }
  let!(:post_categories) do
    ActsAsTenant.with_tenant(user) do
      FactoryBot.create_list(:post_category, 3, user: user)
    end
  end
  let!(:posts) do
    ActsAsTenant.with_tenant(user) do
      [
        FactoryBot.create(:post, :published, post_categories: [post_categories.sample]),
        FactoryBot.create(:post, :published, post_categories: [post_categories.sample]),
        FactoryBot.create(:post, post_categories: [post_categories.sample]),
      ]
    end
  end

  before do
    ActsAsTenant.test_tenant = user
    sign_in(user, scope: :user)
    visit manage_posts_path
  end

  scenario 'Listing posts' do
    cards = page.all('.card', count: posts.size)

    posts.each do |post|
      within("[data-post-id='#{post.id}']") do

        within("header") do
          expect(page).to have_content(post.title)

          if post.published
            expect(page).to have_content("Published #{post.published_on.strftime("%b %-d, %Y")}")
          else
            expect(page).to have_content("Draft")
          end
        end

        within("section") do
          expect(crunch(page.text)).to have_content(post_summary_text(post))

          post.post_categories.each do |category|
            expect(page).to have_content("##{category.name}")
          end
        end

        within("footer") do
          expect(page).to have_content("Updated #{time_ago_in_words(post.updated_at)} ago")
          expect(page).to have_content("Edit")
          expect(page).to have_content("Delete")
        end
      end
    end
  end

  scenario "Listing page has feed links" do
    expect(page).to have_link("RSS", href: posts_feed_path(format: :rss))
    expect(page).to have_link("Atom", href: posts_feed_path(format: :atom))
  end

  private

  def crunch(text)
    text.gsub(/\s+/, " ").chomp
  end

  def post_summary_text(post)
    # Snippets are ~500 but the way it truncates is not always exactly at 500,
    # depending on the text, so we'll go a tick lower for the omission characters
    post_text(post.body.truncate(475, omission: "")).chomp
  end

  def post_text(post_body)
    html = ApplicationHelper.markdown(post_body)
    text = Nokogiri::HTML5.fragment(html).text.chomp
    crunch(text)
  end
end
