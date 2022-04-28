# frozen_string_literal: true

module Playlists
  class InsertContentAtPlaylistService < ApplicationService
    attr_reader :id, :content_id, :position

    def initialize(id, content_id, position)
      @id = id
      @content_id = content_id
      @position = position
    end

    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: "playlist not found") if playlist.blank?

      playlist_content = playlist.contents.find_by(id: content_id)

      if playlist_content.blank?
        return OpenStruct.new(success?: false, playlist: nil,
                              errors: "content not found")
      end

      playlist_content.insert_at(position.to_i)

      OpenStruct.new(success?: true, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
