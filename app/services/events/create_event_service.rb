# frozen_string_literal: true

module Events
  class CreateEventService < AuthorizedService
    attr_reader :name

    def initialize(current_user:, name:)
      super(current_user:)
      @name = name
    end

    def call
      event = current_user.events.new(name:)

      OpenStruct.new(success?: event.save, event:, errors: event.errors.full_messages)
    end
  end
end
