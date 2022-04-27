# frozen_string_literal: true

module Events
  class DeleteEventService < ApplicationService
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      event = Event.find_by(id:)

      return OpenStruct.new(success?: false, event: nil, errors: ["event not found"]) if event.blank?

      event.destroy
      OpenStruct.new(success?: event.destroyed?, event:, errors: event.errors.full_messages)
    end
  end
end
