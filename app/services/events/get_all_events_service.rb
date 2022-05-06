# frozen_string_literal: true

module Events
  class GetAllEventsService < AuthorizedService
    def call
      events = current_user.events.first(50) # Event.where(user_id: current_user.id).first(50)

      return OpenStruct.new(success?: false, user: nil, errors: ["Events not found"]) if events.blank?

      OpenStruct.new(success?: true, events:)
    end
  end
end
