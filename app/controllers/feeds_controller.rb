class FeedsController < ApplicationController
  layout false

  def posts
    authorize(Post, :index?)

    @posts = policy_scope(Post).
      includes(:post_categories).
      order(published_on: :desc, updated_at: :desc, created_at: :desc).
      limit(15)

    if stale?(@posts, public: true)
      respond_to do |format|
        format.atom
        format.rss
      end
    end
  end
end
