require 'rails_helper'

RSpec.describe 'Managing Posts', type: :system do
  include ActionView::Helpers::DateHelper

  let!(:user) { FactoryBot.create(:user) }
  let!(:post_categories) do
    FactoryBot.create_list(:post_category, 3, user: user)
  end
  let!(:posts) do
    [
      FactoryBot.create(:post, :published, post_categories: [post_categories.sample], user: user),
      FactoryBot.create(:post, :published, post_categories: [post_categories.sample], user: user),
      FactoryBot.create(:post, post_categories: [post_categories.sample], user: user),
    ]
  end

  before do
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

  scenario 'Creating a post', js: true do
    click_link('New Post')

    fill_in('post_title', with: 'My new post about Project ACME')

    fill_in_editor_field('Project ACME is a project about nothing, so I thought you all would find it interesting')
    check("post_post_category_ids_#{post_categories.first.id}")
    click_button('Create Post')

    expect(page).to have_current_path(manage_posts_path)

    expect(page).to have_content("'My new post about Project ACME' was successfully created")
    expect(page).to have_content('Project ACME is a project about nothing')
  end

  scenario 'Editing a post', js: true do
    post = posts.sample

    click_link(post.title)

    expect(page).to have_current_path(edit_manage_post_path(post))

    category = post.post_categories.first

    fill_in('post_title', with: "EDITED: #{post.title}")
    fill_in_editor_field("EDITED:\n#{post.body}")
    uncheck("post_post_category_ids_#{category.id}")
    click_button('Update Post')

    expect(page).to have_content("'EDITED: #{post.title}' was successfully updated.")
    expect(page).to have_current_path(manage_posts_path)

    within("[data-post-id='#{post.id}']") do
      expect(page).to have_content("EDITED: #{post.title}")
      expect(crunch(page.text)).to have_content("EDITED: #{post_summary_text(post)[0, 40]}")
      expect(page).to have_content("Updated less than a minute ago")
      expect(page).not_to have_content("##{category.name}")
    end
  end

  scenario 'Deleting a post' do
    post = posts.sample

    click_link(post.title)

    expect(page).to have_current_path(edit_manage_post_path(post))

    click_link('Delete')

    expect(page).to have_current_path(manage_posts_path)

    expect(page).to have_content("'#{post.title}' was successfully destroyed")

    expect { post.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  private

  # Thanks Eliot Sykes!
  # https://eliotsykes.com/2016/11/18/testing-codemirror-editor/
  def fill_in_editor_field(text)
    within ".CodeMirror" do
      current_scope.click
      field = current_scope.find("textarea", visible: false)
      field.send_keys text
    end
  end

  def have_editor_display(**options)
    editor_display_locator = ".CodeMirror-code"
    have_css(editor_display_locator, **options)
  end

  def crunch(text)
    text.gsub(/\s+/, " ").chomp
  end

  def post_summary_text(post)
    # Snippets are ~500 but the way it truncates is not always exactly at 500,
    # depending on the text, so we'll go a tick lower for the omission characters
    post_text(post.body.truncate(450, omission: "")).chomp
  end

  def post_text(post_body)
    html = ApplicationHelper.markdown(post_body)
    text = Nokogiri::HTML5.fragment(html).text.chomp
    crunch(text)
  end
end
