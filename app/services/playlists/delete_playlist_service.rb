# frozen_string_literal: true

module Playlists
  class DeletePlaylistService < ApplicationService
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      playlist.destroy

      OpenStruct.new(success?: playlist.destroyed?, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
