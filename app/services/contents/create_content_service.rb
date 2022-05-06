# frozen_string_literal: true

module Contents
  class CreateContentService < AuthorizedService
    attr_reader :playlist_id, :attachment

    def initialize(playlist_id:, attachment:, current_user:)
      super(current_user:)
      @playlist_id = playlist_id
      @attachment = attachment
    end

    def call
      content = current_user.contents.new(playlist_id:, attachment:)

      OpenStruct.new(success?: content.save, content:, errors: content.errors.full_messages)
    end
  end
end
