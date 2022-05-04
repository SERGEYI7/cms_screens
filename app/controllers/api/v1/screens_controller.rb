# frozen_string_literal: true

module Api
  module V1
    class ScreensController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Screens::GetAllScreensService.call(current_user:)
        if result.success?
          render json: { screens: serializer_screens(result.screens) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def show
        result = Screens::GetScreenService.call(id: params[:id], current_user:, event_id: params[:event_id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Screens::CreateScreenService.call(name: params[:name], current_user:, event_id: params[:event_id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Screens::UpdateScreenService.call(id: params[:id], name: params[:name], current_user:,
                                                   event_id: params[:event_id])
        if result.success?
          render json: { data: serializer_screen(result.screen) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Screens::DeleteScreenService.call(id: params[:id])
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
