module Api
  module V1
    class PostsController < ApiController
      include ActionController::MimeResponds

      ALLOWED_INCLUDES = [
        'categories'
      ]

      payload_type :post
      before_action :validate_payload_type, only: [:create, :update]
      before_action only: [:create, :update, :destroy] do
        doorkeeper_authorize! :posts_write
      end

      def index
        paginate posts, include: include_params
      end

      def show
        authorize post
        render jsonapi: post, include: include_params
      end

      def create
        new_post = Post.new(post_params)
        authorize new_post
        if new_post.save
          render jsonapi: new_post, status: :created, location: new_post
        else
          render_error resource: new_post
        end
      end

      def update
        authorize post
        if post.update_attributes(post_params)
          render jsonapi: post
        else
          render_error resource: post
        end
      end

      def destroy
        authorize post
        post.destroy!
        head :no_content
      end

      private

      def include_params
        @include_params ||= IncludeParamsValidator.include_params!(
          include_params: params[:include],
          allowed: ALLOWED_INCLUDES
        )
      end

      def post
        @post ||= policy_scope(Post).find(params[:id])
      end

      def posts
        @posts ||= begin
          query = policy_scope(Post)

          if include_params.include?('categories')
            query = query.includes(:post_categories)
          end

          query.order(published_on: :desc, updated_at: :desc, created_at: :desc)
        end
      end

      def post_params
        ActiveModelSerializers::Deserialization.jsonapi_parse!(
          params, only: [
            :title, :body, :published, :published_on
          ]
        ).merge(user: current_tenant)
      end
    end
  end
end
