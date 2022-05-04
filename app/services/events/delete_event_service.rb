# frozen_string_literal: true

module Events
  class DeleteEventService < ApplicationService
    def call
      event = Event.find_by(id:)

      return OpenStruct.new(success?: false, event: nil, errors: ["event not found"]) if event.blank?

      begin
        authorize event, :destroy?
      rescue StandardError
        return OpenStruct.new(success?: false, event: nil, errors: ["must be logged in"])
      end

      event.destroy

      OpenStruct.new(success?: event.destroyed?, event:, errors: event.errors.full_messages)
    end
  end
end
