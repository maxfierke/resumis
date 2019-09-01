require 'sidekiq/web'

Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  constraints(AuthHostConstraint.new) do
    devise_for :users, path: 'auth/user',
                       controllers: { registrations: 'users/registrations'}
  end

  constraints(BareHostConstraint.new) do
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

    if ResumisConfig.multi_tenant?
      # Redirect other requests to the site at www.
      match '*path', to: redirect { |path_params, req| "#{req.protocol}www.#{req.domain}#{req.fullpath}" }, via: :get
    end
  end

  constraints(TenantHostConstraint.new) do
    namespace :api do
      scope module: :v1, constraints: ApiVersionConstraint.new(version: 'v1') do
        resources :posts, only: [:index, :create, :show, :update, :delete]
        resources :projects, only: [:index, :create, :show, :update, :delete]
        resources :resumes, only: [:index, :create, :show, :update, :delete]
        resources :users, only: [:show]
      end

      scope module: :json_resume, constraints: JsonResumeConstraint.new do
        resources :resumes, only: [:show]
      end
    end
    use_doorkeeper scope: 'api/oauth2' do
      controllers :applications => 'api/applications'
    end

    resources :resumes, only: [:show]

    namespace :manage do
      resources :resumes, concerns: :paginatable
      resources :education_experiences, path: 'experiences/education', concerns: :paginatable
      resources :work_experiences, path: 'experiences/work', concerns: :paginatable

      resources :posts, path: 'blog/posts', except: [:show], concerns: :paginatable
      resources :post_categories, path: 'blog/categories', except: [:index, :show]
      resources :projects, concerns: :paginatable
      resources :project_statuses, path: 'project/statuses', except: [:index]
      resources :project_categories, path: 'project/categories', except: [:index]
      resources :skill_categories, path: 'skill/categories', concerns: :paginatable do
        resources :skills, except: [:index]
      end
      resources :users, except: [:new, :create, :show], concerns: :paginatable do
        member do
          patch 'unlock'
          patch 'disable'
          patch 'enable'
        end
      end

      get 'skills' => 'skills#index', as: :skills
      post 'skills' => 'skills#create'

      get 'profile/edit' => 'profile#edit', as: :edit_profile
      put 'profile' => 'profile#update'
      patch 'profile' => 'profile#update'

      get '/' => 'dashboard#index', as: :dashboard
    end

    if ResumisConfig.multi_tenant?
      get 'auth/user/*path', to: redirect { |path_params, req| "#{req.protocol}accounts.#{req.domain}#{req.fullpath}" }
    end
  end

  root 'manage/dashboard#index'
end
