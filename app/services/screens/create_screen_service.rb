# frozen_string_literal: true

module Screens
  class CreateScreenService < ApplicationService
    def call
      screen = Screen.new(name:, user_id: current_user.id, event_id:)
      authorize screen, :create?

      OpenStruct.new(success?: screen.save, screen:, errors: screen.errors.full_messages)
    end
  end
end
