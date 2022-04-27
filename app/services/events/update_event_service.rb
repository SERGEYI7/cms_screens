# frozen_string_literal: true

module Events
  class UpdateEventService < ApplicationService
    attr_reader :id, :name, :user_id

    def initialize(id, name, user_id)
      @id = id
      @name = name
      @user_id = user_id
    end

    def call
      event = Event.find_by(id:)

      return OpenStruct.new(success?: false, event: nil, errors: ["event not found"]) if event.blank?

      event.update(name:, user_id:)

      OpenStruct.new(success?: true, event:, errors: event.errors.full_messages)
    end
  end
end
