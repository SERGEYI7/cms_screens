# frozen_string_literal: true

module Playlists
  class PlaylistContentMoveToBottomService < ApplicationService
    attr_reader :id, :content_id

    def initialize(id, content_id)
      @id = id
      @content_id = content_id
    end

    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: "playlist not found") if playlist.blank?

      playlist_content = playlist.contents.find_by(id: content_id)

      if playlist_content.blank?
        return OpenStruct.new(success?: false, playlist: nil,
                              errors: "content not found")
      end

      playlist_content.move_to_bottom

      OpenStruct.new(success?: true, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
