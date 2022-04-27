# frozen_string_literal: true

module Contents
  class DeleteContentService < ApplicationService
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      content = Content.find_by(id:)

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      content.destroy
      OpenStruct.new(success?: content.destroyed?, content:, errors: content.errors.full_messages)
    end
  end
end
