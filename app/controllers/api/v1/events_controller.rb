# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = Events::GetAllEventsService.call(current_user:)

        render json: { data: serialize_events(result.events) }, status: :ok
      end

      def show
        result = Events::GetEventService.call(id: params[:id], current_user:)
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Events::CreateEventService.call(name: params[:name], current_user:)
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Events::DeleteEventService.call(id: params[:id], current_user:)
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        result = Events::UpdateEventService.call(
          id: params[:id],
          name: params[:name],
          current_user:
        )
        if result.success?
          render json: { data: serializer_event(result.event) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serialize_events(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: EventSerializer)
      end

      def serializer_event(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: EventSerializer)
      end
    end
  end
end
