# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def me
        result = Users::MeService.call(current_user:)

        render json: { data: ActiveModelSerializers::SerializableResource.new(result.user, serializer: UserSerializer) },
               status: :ok
      end
    end
  end
end
