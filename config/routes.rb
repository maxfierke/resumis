require 'sidekiq/web'

Rails.application.routes.draw do
  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? '' : /.*/) do
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

    devise_for :users, path: 'auth/user',
                       controllers: { registrations: 'users/registrations'}

    if Rails.application.config.x.resumis.tenancy_mode == :multi
      if Rails.application.config.x.resumis.listing_enabled
        get '/' => 'page#bare_domain'
      end

      # Redirect other requests to the site at www.
      match '*path', to: redirect { |path_params, req| "#{req.protocol}www.#{req.domain}#{req.fullpath}" }, via: :get
    end
  end

  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? /.+/ : /.*/) do
    resources :posts, path: 'blog/posts', only: [:index, :show]
    resources :post_categories, path: 'blog/categories', only: [:index, :show]
    resources :resumes, only: [:show]
    resources :projects, only: [:index, :show]

    namespace :manage do
      resources :resumes
      resources :education_experiences, path: 'experiences/education'
      resources :work_experiences, path: 'experiences/work'

      resources :posts, path: 'blog/posts', except: [:show]
      resources :post_categories, path: 'blog/categories', except: [:show]
      resources :projects
      resources :project_statuses, path: 'project/statuses'
      resources :project_categories, path: 'project/categories'
      resources :skill_categories, path: 'skill/categories' do
        resources :skills, except: [:index]
      end

      get 'skills' => 'skills#index', as: :skills
      post 'skills' => 'skills#create'

      get 'profile/edit' => 'profile#edit', as: :edit_profile
      put 'profile' => 'profile#update'
      patch 'profile' => 'profile#update'

      get '/' => 'dashboard#index', as: :dashboard
    end

    get 'blog' => 'posts#index'
    get 'profile' => 'profile#show'
    get 'about', to: redirect('/')
  end

  root 'profile#show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
