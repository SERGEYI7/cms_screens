# frozen_string_literal: true

module Events
  class GetEventService < ApplicationService
    def call
      var_find_event = find_event
      return OpenStruct.new(success?: false, event: nil, errors: ["Event not found"]) if var_find_event.blank?

      begin
        authorize var_find_event, :show?
      rescue StandardError
        return OpenStruct.new(success?: false, event: nil, errors: ["must be logged in"])
      end

      # authorize_user_model('event', var_find_event, :show?)

      OpenStruct.new(success?: true, event: var_find_event, errors: var_find_event.errors.full_messages)
    end

    private

    def find_event
      Event.find_by(id:)
    end
  end
end
