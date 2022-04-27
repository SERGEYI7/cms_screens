# frozen_string_literal: true

module Screens
  class CreateScreenService < ApplicationService
    attr_reader :name, :user_id, :event_id

    def initialize(name, user_id, event_id)
      @name = name
      @user_id = user_id
      @event_id = event_id
    end

    def call
      screen = Screen.new(name:, user_id:, event_id:)

      OpenStruct.new(success?: screen.save, screen:, errors: screen.errors.full_messages)
    end
  end
end
