# frozen_string_literal: true

module Users
  class GetUserService < ApplicationService
    def call
      user = User.find_by(id:)

      # return OpenStruct.new(success?: false, user: nil, errors: ["User not found"]) if user.blank?

      begin
        authorize user, :show?
      rescue StandardError
        return OpenStruct.new(success?: false, user: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, user:, errors: user.errors.full_messages)
    end
  end
end
