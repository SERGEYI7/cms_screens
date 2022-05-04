# frozen_string_literal: true

module Playlists
  class PlaylistContentMoveToBottomService < ApplicationService
    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: "playlist not found") if playlist.blank?

      begin
        authorize playlist, :update?
      rescue StandardError
        return OpenStruct.new(success?: false, playlist: nil, errors: ["must be logged in"])
      end

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
