Rails.application.routes.draw do
  # devise_for :users
    devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/register" => "devise/registrations#new"
  end
   get 'posts/search' => 'posts#search'

  
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end
  
  root 'home#index'
  get 'home/index'
  get 'home/login'
  get 'home/mypage'
  get 'home/myfood'
  get 'home/myplace'
  get 'home/mysleep'
  get 'home/course'
  
  get 'tsp/routing'
  get 'tsp/queryApi'
  
  get 'posts/index' #자유게시판
  get 'posts/service1' #자주묻는질문
  get 'posts/service2' #상담&문의
  # get 'posts/index'
  get 'posts/board'
  

  
  
  ##info
  get 'infos/create'
  #read
  get '/infos/show/:info_id' => 'infos#show'
  get 'infos/place_show' #장소 view
  get 'infos/food_show' #음식점 view
  get 'infos/sleep_show' #숙소 view
  
  get '/infos/place_info_show/:info_id' => 'infos#place_info_show' #장소 세부정보 view
  get '/infos/food_info_show/:info_id' => 'infos#food_info_show' #음식점 세부정보 view
  get '/infos/sleep_info_show/:info_id' => 'infos#sleep_info_show' #숙소 세부정보 view
  
  #review
  delete '/reviews/:id' => 'reviews#destroy', as: "review"
  resources :infos do
    resources :reviews
  end
  resources :reviews  
  
  
   #좋아요
  post "/infos/:info_id/like", to: "likes#like_toggle", as:"info_like"
  
   #코스추천
  post "/infos/:info_id/course", to: "courses#course_toggle", as:"info_course"

  #Create
  get '/posts/new'
  post '/posts/create'
  
  #Read
  get '/posts/index'
  get '/posts/show/:post_id' => 'posts#show', as: "post"
  
  #Update
  get '/posts/edit/:post_id' => 'posts#edit', as: "edit_post"
  post '/posts/update/:post_id' => 'posts#update', as: "update_post"
  
  #Delete
  delete '/posts/destroy/:post_id' => 'posts#destroy', as: "delete_post"
  
  resources :posts do
    resources :comments
  end
  resources :comments
  
  # 검색
  resources :posts do
    collection do
      get :search
    end
  end

 
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
