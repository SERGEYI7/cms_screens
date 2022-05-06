# frozen_string_literal: true

module Events
  class GetEventService < AuthorizedService
    attr_reader :id

    def initialize(current_user:, id:)
      super(current_user:)
      @id = id
    end

    def call
      event = current_user.events.find_by(id:)
      return OpenStruct.new(success?: false, event: nil, errors: ["Event not found"]) if event.blank?

      OpenStruct.new(success?: true, event:, errors: event.errors.full_messages)
    end
  end
end
