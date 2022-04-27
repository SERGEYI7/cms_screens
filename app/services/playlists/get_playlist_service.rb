# frozen_string_literal: true

module Playlists
  class GetPlaylistService < ApplicationService
    attr_reader :id, :user_id, :screen_id

    def initialize(id, user_id = nil, screen_id = nil)
      @id = id
      @user_id = user_id
      @screen_id = screen_id
    end

    def call
      if find_playlist.blank?
        return OpenStruct.new(success?: false, playlist: nil,
                              errors: ["playlist not found"])
      end

      OpenStruct.new(success?: true, playlist: find_playlist, errors: find_playlist.errors.full_messages)
    end

    private

    def find_playlist
      if user_id.present? && screen_id.present?
        return Playlist.find_by(id:, user_id:,
                                screen_id:)
      end
      return Playlist.find_by(id:, user_id:) if user_id.present?

      Playlist.find_by(id:)
    end
  end
end
