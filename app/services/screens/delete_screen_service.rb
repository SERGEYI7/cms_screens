# frozen_string_literal: true

module Screens
  class DeleteScreenService < AuthorizedService
    attr_reader :id

    def initialize(current_user:, id:)
      super(current_user:)
      @id = id
    end

    def call
      screen = current_user.screens.find_by(id:)

      return OpenStruct.new(success?: false, screen: nil, errors: ["screen not found"]) if screen.blank?

      authorize screen, :destroy?

      screen.destroy

      OpenStruct.new(success?: screen.destroyed?, screen:, errors: screen.errors.full_messages)
    end
  end
end
