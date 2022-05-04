# frozen_string_literal: true

module Events
  class CreateEventService < ApplicationService
    def call
      event = Event.new(name:, user_id: current_user.id)
      authorize event, :create?

      OpenStruct.new(success?: event.save, event:, errors: event.errors.full_messages)
    end
  end
end
