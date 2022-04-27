# frozen_string_literal: true

module Events
  class GetAllEventsService < ApplicationService
    attr_reader :user_id

    def initialize(user_id = nil)
      @user_id = user_id
    end

    def call
      events ||= Event.where(user_id:) if user_id.present?
      events ||= Event.first(50)
      OpenStruct.new(events:)
    end
  end
end
