# frozen_string_literal: true

module Playlists
  class DeletePlaylistService < ApplicationService
    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      begin
        authorize playlist, :destrooy?
      rescue StandardError
        return OpenStruct.new(success?: false, playlist: nil, errors: ["must be logged in"])
      end

      playlist.destroy

      OpenStruct.new(success?: playlist.destroyed?, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
