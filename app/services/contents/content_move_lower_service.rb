# frozen_string_literal: true

module Contents
  class ContentMoveLowerService < AuthorizedService
    attr_reader :content_id

    def initialize(current_user:, content_id:)
      super(current_user:)
      @content_id = content_id
    end

    def call
      content = current_user.contents.find_by(id: content_id)

      return OpenStruct.new(success?: false, content: nil, errors: "content not found") if content.blank?

      authorize content, :update?
      content.move_lower

      OpenStruct.new(success?: true, content:, errors: content.errors.full_messages)
    end
  end
end
