# frozen_string_literal: true

module Events
  class UpdateEventService < AuthorizedService
    attr_reader id:, name:
    def initialize(current_user:, id:, name:)
      super(current_user:)
      @id = id
      @name = name
    end

    def call
      event = current_user.events.find_by(id:)

      return OpenStruct.new(success?: false, event: nil, errors: ["event not found"]) if event.blank?

      authorize event, :update?

      event.update(name:)

      OpenStruct.new(success?: true, event:, errors: event.errors.full_messages)
    end
  end
end
