module Manage
  class PostCategoriesController < ManageController
    before_action :set_post_category, only: [:edit, :update, :destroy]

    def new
      @post_category = PostCategory.new
      authorize @post_category
    end

    def edit
    end

    def create
      @post_category = PostCategory.new(post_category_params)
      authorize @post_category

      respond_to do |format|
        if @post_category.save
          format.html { redirect_to manage_posts_path, notice: 'Post category was successfully created.' }
          format.json { render :show, status: :created, location: manage_posts_path }
        else
          format.html { render :new }
          format.json { render json: @post_category.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post_category.update(post_category_params)
          format.html { redirect_to manage_posts_path, notice: 'Post category was successfully updated.' }
          format.json { render :show, status: :ok, location: manage_posts_path }
        else
          format.html { render :edit }
          format.json { render json: @post_category.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post_category.destroy
      respond_to do |format|
        format.html { redirect_to manage_posts_path, notice: 'Post category was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post_category
        @post_category = PostCategory.find(params[:id])
        authorize @post_category
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_category_params
        params.require(:post_category).permit(:name)
      end
  end
end
