VoterLogAnalytics::Application.routes.draw do
  resources :selections
  resources :elections
  resources :voter_transaction_logs
  resources :voter_transaction_records

#  get "pages/front"
  root :to => "pages#front"

  resource :uplift, only: [], path: '' do
    member do
      post :uplift
    end
  end

  resource :page, only: [], path: '' do
    member do
      get :front
      get :help
      get :about
      get :security
      get :feedback
      get :analyze
    end
  end

  resource :election, only: [], path: '' do
    member do
      get :index
      get :edit
      get :show
      get :new
    end
  end

  resource :voter_transaction_record, only: [], path: '' do
    member do
      get :index
      get :edit
      get :create
      get :show
      get :new
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
