Rails.application.routes.draw do
  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? '' : /.*/) do
    devise_for :users, path: 'auth/user',
                       controllers: { registrations: 'users/registrations'}
    if Rails.application.config.x.resumis.tenancy_mode == :multi
      get '/' => 'page#bare_domain'

      # Redirect other requests to the site at www.
      match '*path', to: redirect { |path_params, req| "#{req.protocol}www.#{req.domain}#{req.fullpath}" }, via: :get
    end
  end

  constraints subdomain: (Rails.application.config.x.resumis.tenancy_mode == :multi ? /.+/ : /.*/) do
    resources :resumes

    resources :education_experiences, path: 'experiences/education'

    resources :work_experiences, path: 'experiences/work'

    resources :skill_categories, path: 'skill/categories' do
      resources :skills
    end

    get 'skills' => 'skills#index', as: :skills
    post 'skills' => 'skills#create'

    resources :project_categories, path: 'project/categories'

    resources :projects

    resources :project_statuses, path: 'project/statuses'

    get 'profile/edit' => 'profile#edit', as: :edit_profile
    get 'profile' => 'profile#show'
    put 'profile' => 'profile#update'
    patch 'profile' => 'profile#update'

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
