require 'sidekiq/web'

Rails.application.routes.draw do
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
end
