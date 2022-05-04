# frozen_string_literal: true

module Users
  class GetAllUsersService < ApplicationService
    def call
      users = User.where(id: current_user.id).first(50)
      authorize users[0], :index?

      OpenStruct.new(success?: true, users:)
    end
  end
end
