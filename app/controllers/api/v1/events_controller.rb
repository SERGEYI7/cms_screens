# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Events::GetAllEventsService.call
        render json: { data: serializer_events(result.events) }, status: :ok
      end

      def show
        result = Events::GetEventService.call(params[:id])
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Events::CreateEventService.call(params[:name], params[:user_id])
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Events::DeleteEventService.call(params[:id])
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Events::UpdateEventService.call(
          params[:id],
          params[:name],
          params[:user_id]
        )
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serializer_events(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: EventSerializer)
      end

      def serializer_event(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: EventSerializer)
      end
    end
  end
end
