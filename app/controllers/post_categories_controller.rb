class PostCategoriesController < ApplicationController
  layout "blog", only: [:index, :show]

  def index
    @post_categories = PostCategory.all
  end

  def show
    @post_category = PostCategory.find(params[:id])
    @posts = @post_category.posts.where(published: true)

    render template: 'posts/index'
  end
end
