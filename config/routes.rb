Rails.application.routes.draw do


  scope module: :user do

    get 'users/my_page' => "users#show"
    resources :users, only: [:update, :edit]

    root to: 'homes#top'
    get 'homes/about'

    resources :posts, only: [:new, :show, :index, :edit, :update, :destroy, :create] do
      get :search, on: :collection
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: "user/sessions",
  }


  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

    namespace :admin do

    get '/' => 'homes#top'

    resources :users, only: [:show, :edit, :update]

    resources :posts, only: [:show, :index, :destroy]


  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
