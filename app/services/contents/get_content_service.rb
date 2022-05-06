# frozen_string_literal: true

module Contents
  class GetContentService < AuthorizedService
    attr_reader :id, :playlist_id

    def initialize(id:, playlist_id:, current_user:)
      super(current_user:)
      @id = id
      @playlist_id = playlist_id
    end

    def call
      content = find_content

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      OpenStruct.new(success?: true, content:, errors: nil)
    end

    private

    def find_content
      return current_user.contents.find_by(id:, playlist_id:) if playlist_id.present?

      current_user.contents.find_by(id:)
    end
  end
end
