# frozen_string_literal: true

module Contents
  class UpdateContentService < AuthorizedService
    attr_reader :id, :playlist_id, :attachment

    def initialize(id:, playlist_id:, attachment:, current_user:)
      super(current_user:)
      @id = id
      @playlist_id = playlist_id
      @attachment = attachment
    end

    def call
      content = current_user.contents.find_by(id:)

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      authorize content, :update?

      content.update(
        playlist_id:,
        attachment:
      )

      OpenStruct.new(success?: true, content:, errors: content.errors.full_messages)
    end
  end
end
