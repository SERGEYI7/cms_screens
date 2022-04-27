# frozen_string_literal: true

module Screens
  class GetScreenService < ApplicationService
    attr_reader :id, :user_id, :event_id

    def initialize(id, user_id = nil, event_id = nil)
      @id = id
      @user_id = user_id
      @event_id = event_id
    end

    def call
      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if find_screen.blank?

      OpenStruct.new(success?: true, screen: find_screen, errors: nil)
    end

    private

    def find_screen
      return Screen.find_by(id:, user_id:, event_id:) if user_id.present? && event_id.present?
      return Screen.find_by(id:, user_id:) if user_id.present?

      Screen.find_by(id:)
    end
  end
end
