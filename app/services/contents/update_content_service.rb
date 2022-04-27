# frozen_string_literal: true

module Contents
  class UpdateContentService < ApplicationService
    attr_reader :id, :user_id, :playlist_id, :attachment

    def initialize(id, user_id, playlist_id, attachment)
      @id = id
      @user_id = user_id
      @playlist_id = playlist_id
      @attachment = attachment
    end

    def call
      content = Content.find_by(id:)

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      content.update(
        user_id:,
        playlist_id:,
        attachment:
      )

      OpenStruct.new(success?: true, content:, errors: content.errors.full_messages)
    end
  end
end
