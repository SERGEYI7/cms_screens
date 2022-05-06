# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"

      get "me", to: "users#me"

      resources :events do
        resources :screens, only: %i[show index]
      end

      resources :screens do
        resources :playlists, only: %i[show index]
      end

      resources :playlists do
        resources :contents,  only: %i[show index]
      end

      resources :contents do
        post "insert_at", to: "contents#content_insert_at"
        post "move_lower", to: "contents#content_move_lower"
        post "move_higher", to: "contents#content_move_higher"
        post "move_to_bottom", to: "contents#content_move_to_bottom"
        post "move_to_top", to: "contents#content_move_to_top"
        post "remove_from_list", to: "contents#content_remove_from_list"
      end
    end
  end
end
