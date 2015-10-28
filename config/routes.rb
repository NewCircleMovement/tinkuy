Tinkuy::Application.routes.draw do

  
  # Added by Koudoku.
  mount Koudoku::Engine, at: 'members'
  scope module: 'koudoku' do
    get 'membership' => 'subscriptions#index', as: 'membership'
  end


  namespace :admin do
    get '/' => 'events#index'
    resources :users
    resources :events
    resources :plans
    resources :centers
    resources :memberships
    resources :resources do
      resources :timeslots do
        member do
          put :toggle_booking
        end
      end
    end
  end
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    get '/events' => "users#events"
  end
  
  resources :resources do
    # resources :bookings
    resources :timeslots do
      resources :bookings
    end
  end

  resources :recurring_bookings

  resources :events do
    member { 
      post :upvote
    }
  end

  get '/suggestions' => 'events#suggestions'
  
  get '/info' => 'pages#info'
  get '/faq' => 'pages#faq'
  get '/bliv_medlem' => 'pages#bliv_medlem'

  root :to => "pages#bliv_medlem"
  # root :to => "pages#index"


  
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
