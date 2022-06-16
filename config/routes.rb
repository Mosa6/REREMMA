Rails.application.routes.draw do

  scope module: :user do

    get 'users/my_page' => "users#show"
    resources :users, only: [:update, :edit]

    root to: 'homes#top'
    get 'homes/about'

    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end
  end
  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: "user/sessions",
  }
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
