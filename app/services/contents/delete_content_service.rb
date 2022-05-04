# frozen_string_literal: true

module Contents
  class DeleteContentService < ApplicationService
    def call
      content = Content.find_by(id:)

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      begin
        authorize content, :destroy?
      rescue StandardError
        return OpenStruct.new(success?: false, content: nil, errors: ["must be logged in"]) if content.blank?
      end

      content.destroy

      OpenStruct.new(success?: content.destroyed?, content:, errors: content.errors.full_messages)
    end
  end
end
