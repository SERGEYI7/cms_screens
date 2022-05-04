# frozen_string_literal: true

module Events
  class GetAllEventsService < ApplicationService
    def call
      events = Event.where(user_id: current_user.id).first(50)

      return OpenStruct.new(success?: false, user: nil, errors: ["Events not found"]) if events.blank?

      begin
        authorize events[0], :index?
      rescue StandardError
        return OpenStruct.new(success?: false, user: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, events:)
    end
  end
end
