module Manage
  class PostsController < ManageController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
      @posts = Post.order(id: :desc).page params[:page]
    end

    def show
    end

    def new
      @post = Post.new
    end

    def edit
    end

    def create
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to post_url(@post), notice: "'#{@post.title}' was successfully created." }
          format.json { render :show, status: :created, location: post_url(@post) }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: "'#{@post.title}' was successfully updated." }
          format.json { render :show, status: :ok, location: post_url(@post) }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to manage_posts_url, notice: "'#{@post.title}' was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params[:post].permit(:title, :body, :published, :published_on, post_category_ids: [])
      end
  end
end
