# frozen_string_literal: true

module Screens
  class CreateScreenService < AuthorizedService
    attr_reader :name, :event_id

    def initialize(current_user:, name:, event_id:)
      super(current_user:)
      @name = name
      @event_id = event_id
    end

    def call
      screen = current_user.screens.new(name:, event_id:)

      OpenStruct.new(success?: screen.save, screen:, errors: screen.errors.full_messages)
    end
  end
end
