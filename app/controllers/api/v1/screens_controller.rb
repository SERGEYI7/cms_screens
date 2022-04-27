# frozen_string_literal: true

module Api
  module V1
    class ScreensController < ApplicationController
      def index
        result = Screens::GetAllScreensService.call
        render json: { data: serializer_screens(result.screens) }, status: :ok
      end

      def show
        result = Screens::GetScreenService.call(params[:id], params[:user_id], params[:event_id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Screens::CreateScreenService.call(params[:name], params[:user_id], params[:event_id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Screens::UpdateScreenService.call(params[:id], params[:name], params[:user_id],
                                                   params[:event_id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Screens::DeleteScreenService.call(params[:id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serializer_screens(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: ScreenSerializer)
      end

      def serializer_screen(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: ScreenSerializer)
      end
    end
  end
end
