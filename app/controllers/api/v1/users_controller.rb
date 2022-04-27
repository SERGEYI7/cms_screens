# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        result = Users::GetAllUsersService.call
        render json: { data: serializer_users(result.users) }, status: :ok
      end

      def show
        result = Users::GetUserService.call(params[:id])
        if result.success?
          render json: { data: serializer_user(result.user) }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def serializer_users(content)
        ActiveModelSerializers::SerializableResource.new(content, each_serializer: UserSerializer)
      end

      def serializer_user(content)
        ActiveModelSerializers::SerializableResource.new(content, serializer: UserSerializer)
      end
    end
  end
end
