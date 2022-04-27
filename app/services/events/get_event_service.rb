# frozen_string_literal: true

module Events
  class GetEventService < ApplicationService
    attr_reader :id, :user_id

    def initialize(id, user_id = nil)
      @id = id
      @user_id = user_id
    end

    def call
      return OpenStruct.new(success?: false, event: nil, errors: ["Event not found"]) if find_event.blank?

      OpenStruct.new(success?: true, event: find_event, errors: find_event.errors.full_messages)
    end

    private

    def find_event
      return Event.find_by(id:, user_id:) if user_id.present?

      Event.find_by(id:)
    end
  end
end
