# frozen_string_literal: true

module Users
  class GetAllUsersService < ApplicationService
    def call
      users = User.first(50)
      OpenStruct.new(users:)
    end
  end
end
