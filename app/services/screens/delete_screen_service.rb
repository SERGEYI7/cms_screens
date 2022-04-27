# frozen_string_literal: true

module Screens
  class DeleteScreenService < ApplicationService
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      screen = Screen.find_by(id:)

      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if screen.blank?

      screen.destroy
      OpenStruct.new(success?: screen.destroyed?, screen:, errors: screen.errors.full_messages)
    end
  end
end
