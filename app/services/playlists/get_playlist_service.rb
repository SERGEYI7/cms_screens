# frozen_string_literal: true

module Playlists
  class GetPlaylistService < AuthorizedService
    attr_reader :id, :screen_id

    def initialize(current_user:, id:, screen_id:)
      super(current_user:)
      @id = id
      @screen_id = screen_id
    end

    def call
      playlist = find_playlist

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      OpenStruct.new(success?: true, playlist:, errors: playlist.errors.full_messages)
    end

    private

    def find_playlist
      return current_user.playlists.find_by(id:, screen_id:) if screen_id.present?

      current_user.playlists.find_by(id:)
    end
  end
end
