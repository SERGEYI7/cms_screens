# frozen_string_literal: true

module Screens
  class UpdateScreenService < ApplicationService
    def call
      screen = Screen.find_by(id:)

      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if screen.blank?

      begin
        authorize screen, :update?
      rescue StandardError
        return OpenStruct.new(success?: false, screen: nil, errors: ["must be logged in"])
      end

      screen.update(
        name:,
        user_id: current_user.id,
        event_id:
      )

      OpenStruct.new(success?: true, screen:, errors: screen.errors.full_messages)
    end
  end
end
