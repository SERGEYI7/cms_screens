# frozen_string_literal: true

module Contents
  class DeleteContentService < AuthorizedService
    attr_reader :id

    def initialize(id:, current_user:)
      super(current_user:)
      @id = id
    end

    def call
      content = current_user.contents.find_by(id:)

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      authorize content, :destroy?

      content.destroy

      OpenStruct.new(success?: content.destroyed?, content:, errors: content.errors.full_messages)
    end
  end
end
