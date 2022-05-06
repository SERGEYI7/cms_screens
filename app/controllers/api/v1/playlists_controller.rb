# frozen_string_literal: true

module Api
  module V1
    class PlaylistsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Playlists::GetAllPlaylistsService.call(current_user:, screen_id: params[:screen_id])

        render json: { data: serialize_playlists(result.playlists) }, status: :ok
      end

      def show
        result = Playlists::GetPlaylistService.call(id: params[:id], current_user:, screen_id: params[:screen_id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Playlists::CreatePlaylistService.call(name: params[:name], current_user:,
                                                       screen_id: params[:screen_id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Playlists::UpdatePlaylistService.call(id: params[:id], name: params[:name], current_user:,
                                                       screen_id: params[:screen_id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Playlists::DeletePlaylistService.call(id: params[:id], current_user:)
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serialize_playlists(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: PlaylistSerializer)
      end

      def serializer_playlist(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: PlaylistSerializer)
      end

      def params_playlist
        params.permit(:position)
      end
    end
  end
end
