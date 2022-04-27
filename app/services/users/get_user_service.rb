# frozen_string_literal: true

module Users
  class GetUserService < ApplicationService
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      user = User.find_by(id:)

      return OpenStruct.new(success?: false, user: nil, errors: ["User not found"]) if user.blank?

      OpenStruct.new(success?: true, user:, errors: user.errors.full_messages)
    end
  end
end
