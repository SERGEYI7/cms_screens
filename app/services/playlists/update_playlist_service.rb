# frozen_string_literal: true

module Playlists
  class UpdatePlaylistService < ApplicationService
    attr_reader :id, :name, :user_id, :screen_id

    def initialize(id, name, user_id, screen_id)
      @id = id
      @name = name
      @user_id = user_id
      @screen_id = screen_id
    end

    def call
      playlist = Playlist.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      playlist.update(name:, user_id:, screen_id:)

      OpenStruct.new(success?: true, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
