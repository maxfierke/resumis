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
        if has_access_to_post?(post)
          render jsonapi: post, include: include_params
        else
          head :forbidden
        end
      end

      def create
        new_post = Post.new(post_params)
        if new_post.save
          render jsonapi: new_post, status: :created, location: new_post
        else
          render_error resource: new_post
        end
      end

      def update
        if post.update_attributes(post_params)
          render jsonapi: post
        else
          render_error resource: post
        end
      end

      def destroy
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
        @post ||= Post.find(params[:id])
      end

      def posts
        # TODO: Replace with real access controls
        @posts ||= begin
          if !current_resource_owner || current_resource_owner.id != current_tenant.id
            query = Post.where(published: true)
          else
            query = Post.all
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

      def has_access_to_post?(post)
        # Only allow viewing of published posts unless the posts is owned by the user
        # TODO: Replace with real access controls
        post.published ||
          (current_resource_owner && current_resource_owner.id != post.user.id)
      end
    end
  end
end
