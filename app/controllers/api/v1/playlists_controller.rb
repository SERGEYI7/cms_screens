# frozen_string_literal: true

module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        result = Playlists::GetAllPlaylistsService.call
        render json: { data: serializer_playlists(result.playlists) }, status: :ok
      end

      def show
        result = Playlists::GetPlaylistService.call(params[:id], params[:user_id], params[:screen_id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Playlists::CreatePlaylistService.call(params[:name], params[:user_id], params[:screen_id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Playlists::UpdatePlaylistService.call(params[:id], params[:name], params[:user_id],
                                                       params[:screen_id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Playlists::DeletePlaylistService.call(params[:id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serializer_playlists(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: PlaylistSerializer)
      end

      def serializer_playlist(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: PlaylistSerializer)
      end
    end
  end
end
