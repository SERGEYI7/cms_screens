# frozen_string_literal: true

module Playlists
  class GetPlaylistService < ApplicationService
    def call
      var_find_playlist = find_playlist
      if var_find_playlist.blank?
        return OpenStruct.new(success?: false, playlist: nil,
                              errors: ["playlist not found"])
      end

      begin
        authorize var_find_playlist, :show?
      rescue StandardError
        return OpenStruct.new(success?: false, playlist: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, playlist: var_find_playlist, errors: var_find_playlist.errors.full_messages)
    end

    private

    def find_playlist
      if current_user.present? && screen_id.present?
        return Playlist.find_by(id:, user_id: current_user.id,
                                screen_id:)
      end
      return Playlist.find_by(id:, user_id: current_user.id) if current_user.present?

      Playlist.find_by(id:)
    end
  end
end
