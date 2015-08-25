class PostCategoriesController < ApplicationController
  before_action :set_post, only: [:show]

  layout "blog", only: [:index, :show]
  respond_to :html, :json

  def index
    @post_categories = PostCategory.all
  end

  def show
    @posts = @post_category.posts.where(published: true)

    render template: 'posts/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post_category = PostCategory.find(params[:id])
    end
end
