# frozen_string_literal: true

module Screens
  class GetAllScreensService < ApplicationService
    def call
      if current_user.present? && event_id.present?
        screens ||= Screen.where(user_id: current_user.id,
                                 event_id:).first(50)
      end
      screens ||= Screen.where(user_id: current_user.id).first(50) if current_user.present?
      screens ||= Screen.first(50)
      p screens

      return OpenStruct.new(success?: false, screens: nil, errors: ["Screens not found"]) if screens.blank?

      begin
        authorize screens[0], :index?
      rescue StandardError
        return OpenStruct.new(success?: false, screens: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, screens:)
    end
  end
end
