# frozen_string_literal: true

module Api
  module V1
    class PlaylistsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Playlists::GetAllPlaylistsService.call(current_user:)
        if result.success?
          render json: { data: serializer_playlists(result.playlists) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
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
        result = Playlists::DeletePlaylistService.call(id: params[:id])
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_insert_at
        result = Playlists::InsertContentAtPlaylistService.call(id: params[:id],
                                                                content_id: params[:content_id],
                                                                position: params[:position],
                                                                current_user:)
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_lower
        result = Playlists::PlaylistContentMoveLowerService.call(id: params[:id],
                                                                 content_id: params[:content_id],
                                                                 current_user:)
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_higher
        result = Playlists::PlaylistContentMoveHigherService.call(id: params[:id],
                                                                  content_id: params[:content_id],
                                                                  current_user:)
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_to_bottom
        result = Playlists::PlaylistContentMoveToBottomService.call(id: params[:id],
                                                                    content_id: params[:content_id],
                                                                    current_user:)
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_to_top
        result = Playlists::PlaylistContentMoveToTopService.call(id: params[:id],
                                                                 content_id: params[:content_id],
                                                                 current_user:)
        if result.success?
          render json: { data: serializer_playlist(result.playlist) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_remove_from_list
        result = Playlists::PlaylistContentRemoveFromListService.call(id: params[:id],
                                                                      content_id: params[:content_id],
                                                                      current_user:)
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
