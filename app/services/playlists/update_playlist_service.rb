# frozen_string_literal: true

module Playlists
  class UpdatePlaylistService < ApplicationService
    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      begin
        authorize playlist, :update?
      rescue StandardError
        return OpenStruct.new(success?: false, playlist: nil, errors: ["must be logged in"])
      end

      playlist.update(name:, user_id: current_user.id, screen_id:)

      OpenStruct.new(success?: true, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
