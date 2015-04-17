require 'sidekiq/web'

Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  # TODO: Clean this up
  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? 'accounts' : /.*/) do
    devise_for :users, path: 'auth/user',
                       controllers: { registrations: 'users/registrations'}
  end

  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? '' : /.*/) do
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

    if Rails.application.config.x.resumis.tenancy_mode == :multi
      if Rails.application.config.x.resumis.listing_enabled
        get '/' => 'page#bare_domain'
      end

      # Redirect other requests to the site at www.
      match '*path', to: redirect { |path_params, req| "#{req.protocol}www.#{req.domain}#{req.fullpath}" }, via: :get
    end
  end

  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? /.+/ : /.*/) do
    resources :posts, path: 'blog/posts', only: [:index, :show], concerns: :paginatable
    resources :post_categories, path: 'blog/categories', only: [:index, :show], concerns: :paginatable
    resources :resumes, only: [:show]
    resources :projects, only: [:index, :show], concerns: :paginatable

    namespace :manage do
      resources :resumes, concerns: :paginatable
      resources :education_experiences, path: 'experiences/education', concerns: :paginatable
      resources :work_experiences, path: 'experiences/work', concerns: :paginatable

      resources :posts, path: 'blog/posts', except: [:show], concerns: :paginatable
      resources :post_categories, path: 'blog/categories', except: [:show]
      resources :projects, concerns: :paginatable
      resources :project_statuses, path: 'project/statuses', concerns: :paginatable
      resources :project_categories, path: 'project/categories', concerns: :paginatable
      resources :skill_categories, path: 'skill/categories', concerns: :paginatable do
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
end
