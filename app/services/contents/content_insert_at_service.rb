# frozen_string_literal: true

module Contents
  class ContentInsertAtService < AuthorizedService
    attr_reader :content_id, :position

    def initialize(current_user:, content_id:, position:)
      super(current_user:)
      @content_id = content_id
      @position = position
    end

    def call
      content = current_user.contents.find_by(id: content_id)

      return OpenStruct.new(success?: false, content: nil, errors: "content not found") if content.blank?

      authorize content, :update?
      content.insert_at(position.to_i)

      OpenStruct.new(success?: true, content:, errors: content.errors.full_messages)
    end
  end
end
