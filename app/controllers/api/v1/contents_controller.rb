# frozen_string_literal: true

module Api
  module V1
    class ContentsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Contents::GetAllContentsService.call(current_user:, playlist_id: params[:playlist_id])

        render json: { data: serialize_contents(result.contents) }, status: :ok
      end

      def show
        result = Contents::GetContentService.call(id: params[:id], current_user:, playlist_id: params[:playlist_id])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Contents::CreateContentService.call(current_user:, playlist_id: params[:playlist_id],
                                                     attachment: params[:attachment])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Contents::UpdateContentService.call(id: params[:id], current_user:, playlist_id: params[:playlist_id],
                                                     attachment: params[:attachment])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Contents::DeleteContentService.call(id: params[:id], current_user:)
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_insert_at
        result = Contents::ContentInsertAtService.call(content_id: params[:content_id], current_user:,
                                                       position: params[:position])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_lower
        result = Contents::ContentMoveLowerService.call(content_id: params[:content_id], current_user:)
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_higher
        result = Contents::ContentMoveHigherService.call(content_id: params[:content_id], current_user:)
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_to_bottom
        result = Contents::ContentMoveToBottomService.call(content_id: params[:content_id], current_user:)
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_move_to_top
        result = Contents::ContentMoveToTopService.call(content_id: params[:content_id], current_user:)
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def content_remove_from_list
        result = Contents::ContentRemoveFromListService.call(content_id: params[:content_id], current_user:)
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serialize_contents(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: ContentSerializer)
      end

      def serializer_content(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: ContentSerializer)
      end
    end
  end
end
