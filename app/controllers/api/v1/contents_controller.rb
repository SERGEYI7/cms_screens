# frozen_string_literal: true

module Api
  module V1
    class ContentsController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]

      def index
        result = Contents::GetAllContentsService.call
        render json: { data: serializer_contents(result.contents) }, status: :ok
      end

      def show
        result = Contents::GetContentService.call(params[:id], params[:user_id], params[:playlist_id])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Contents::CreateContentService.call(params[:user_id], params[:playlist_id], params[:attachment])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        authorize Content.find_by(user_id: current_user.id)
        result = Contents::UpdateContentService.call(params[:id], params[:user_id], params[:playlist_id],
                                                     params[:attachment])
        if result.success?
          render json: { data: serializer_content(result.content) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize Content.find_by(user_id: current_user.id)
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
