# frozen_string_literal: true

module Screens
  class GetAllScreensService < ApplicationService
    attr_reader :user_id, :event_id

    def initialize(user_id = nil, event_id = nil)
      @user_id = user_id
      @event_id = event_id
    end

    def call
      screens ||= Screen.where(user_id:, event_id:).first(50) if user_id.present? && event_id.present?
      screens ||= Screen.where(user_id:).first(50) if user_id.present?
      screens ||= Screen.first(50)
      OpenStruct.new(screens:)
    end
  end
end
