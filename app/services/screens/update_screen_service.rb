# frozen_string_literal: true

module Screens
  class UpdateScreenService < ApplicationService
    attr_reader :id, :name, :user_id, :event_id

    def initialize(id, name, user_id, event_id)
      @id = id
      @name = name
      @user_id = user_id
      @event_id = event_id
    end

    def call
      screen = Screen.find_by(id:)

      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if screen.blank?

      screen.update(
        name:,
        user_id:,
        event_id:
      )

      OpenStruct.new(success?: true, screen:, errors: screen.errors.full_messages)
    end
  end
end
