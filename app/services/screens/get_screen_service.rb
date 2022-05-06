# frozen_string_literal: true

module Screens
  class GetScreenService < AuthorizedService
    attr_reader :id, :event_id

    def initialize(id:, event_id:, current_user:)
      super(current_user:)
      @id = id
      @event_id = event_id
    end

    def call
      screen = find_screen

      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if screen.blank?

      OpenStruct.new(success?: true, screen:, errors: nil)
    end

    private

    def find_screen
      return current_user.screens.find_by(id:, event_id:) if event_id.present?

      current_user.screens.find_by(id:)
    end
  end
end
