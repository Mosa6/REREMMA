Rails.application.routes.draw do

  scope module: :user do
    root to: 'homes#top'
    get 'homes/about'
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
