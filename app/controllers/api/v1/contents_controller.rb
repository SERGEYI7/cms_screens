# frozen_string_literal: true

module Api
  module V1
    class ContentsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Contents::GetAllContentsService.call(current_user:)
        if result.success?
          render json: { data: serializer_contents(result.contents) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
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
        authorize Content.find_by(user_id: current_user.id)
        result = Contents::UpdateContentService.call(id: params[:id], current_user:, playlist_id: params[:playlist_id],
                                                     attachment: params[:attachment])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize Content.find_by(id: params[:id], current_user:)
        result = Contents::DeleteContentService.call(params[:id])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serializer_contents(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: ContentSerializer)
      end

      def serializer_content(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: ContentSerializer)
      end
    end
  end
end
