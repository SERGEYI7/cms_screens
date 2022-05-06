# frozen_string_literal: true

module Screens
  class UpdateScreenService < AuthorizedService
    attr_reader :id, :name, :event_id

    def initialize(id:, name:, event_id:, current_user:)
      super(current_user:)
      @id = id
      @event_id = event_id
      @name = name
    end

    def call
      screen = current_user.screens.find_by(id:)

      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if screen.blank?

      authorize screen, :update?

      screen.update(
        name:,
        event_id:
      )

      OpenStruct.new(success?: true, screen:, errors: screen.errors.full_messages)
    end
  end
end
