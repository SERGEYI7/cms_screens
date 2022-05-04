# frozen_string_literal: true

module Screens
  class GetScreenService < ApplicationService
    def call
      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if find_screen.blank?

      begin
        authorize find_screen, :index?
      rescue StandardError
        return OpenStruct.new(success?: false, event: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, screen: find_screen, errors: nil)
    end

    private

    def find_screen
      return Screen.find_by(id:, user_id: current_user.id, event_id:) if current_user.present? && event_id.present?
      return Screen.find_by(id:, user_id: current_user.id) if current_user.present?

      Screen.find_by(id:)
    end
  end
end
