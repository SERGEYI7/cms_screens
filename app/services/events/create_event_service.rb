# frozen_string_literal: true

module Events
  class CreateEventService < ApplicationService
    attr_reader :name, :user_id

    def initialize(name, user_id)
      @name = name
      @user_id = user_id
    end

    def call
      event = Event.new(name:, user_id:)

      OpenStruct.new(success?: event.save, event:, errors: event.errors.full_messages)
    end
  end
end
