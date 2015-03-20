class PostCategoriesController < ApplicationController
  before_action :set_post, only: [:show]

  layout "blog", only: [:index, :show]
  respond_to :html, :json

  def index
    @post_categories = PostCategory.all
  end

  def show
    @posts = @post_category.posts
    if (!user_signed_in? or current_user != current_tenant)
      @posts = @posts.where(published: true)
    end
    render template: 'posts/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post_category = PostCategory.find(params[:id])
    end
end
