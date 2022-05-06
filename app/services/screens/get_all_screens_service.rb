# frozen_string_literal: true

module Screens
  class GetAllScreensService < AuthorizedService
    attr_reader :event_id

    def initialize(event_id:, current_user:)
      super(current_user:)
      @event_id = event_id
    end

    def call
      screens ||= current_user.screens.where(event_id:).first(50) if event_id.present?
      screens ||= current_user.screens.first(50)

      OpenStruct.new(success?: true, screens:)
    end
  end
end
