# frozen_string_literal: true

module Events
  class UpdateEventService < ApplicationService
    def call
      event = Event.find_by(id:)

      return OpenStruct.new(success?: false, event: nil, errors: ["event not found"]) if event.blank?

      begin
        authorize event, :update?
      rescue StandardError
        return OpenStruct.new(success?: false, event: nil, errors: ["must be logged in"])
      end
      event.update(name:, user_id: current_user.id)

      OpenStruct.new(success?: true, event:, errors: event.errors.full_messages)
    end
  end
end
