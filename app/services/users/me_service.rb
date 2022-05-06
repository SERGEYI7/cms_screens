# frozen_string_literal: true

module Users
  class MeService < AuthorizedService
    def call
      OpenStruct.new(user: current_user)
    end
  end
end
