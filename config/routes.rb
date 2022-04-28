# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"

      resources :users, only: %i[index show] do
        resources :events, only: %i[index show]
        resources :screens, only: %i[index show]
        resources :playlists, only: %i[index show]
        resources :contents, only: %i[index show]
      end

      resources :events, only: %i[update create destroy]
      resources :events, only: %i[show index] do
        resources :screens, only: %i[show index]
      end

      resources :screens, only: %i[update create destroy]
      resources :screens, only: %i[show index] do
        resources :playlists, only: %i[show index]
      end

      post "playlists/:id/contents/:content_id/insert_at/:position", to: "playlists#content_insert_at"
      post "playlists/:id/contents/:content_id/move_lower", to: "playlists#content_move_lower"
      post "playlists/:id/contents/:content_id/move_higher", to: "playlists#content_move_higher"
      post "playlists/:id/contents/:content_id/move_to_bottom", to: "playlists#content_move_to_bottom"
      post "playlists/:id/contents/:content_id/move_to_top", to: "playlists#content_move_to_top"
      post "playlists/:id/contents/:content_id/remove_from_list", to: "playlists#content_remove_from_list"

      resources :playlists, only: %i[update create destroy]
      resources :playlists, only: %i[show index] do
        resources :contents, only: %i[show index]
      end

      resources :contents
    end
  end
end
