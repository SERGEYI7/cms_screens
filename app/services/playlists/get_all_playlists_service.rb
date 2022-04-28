# frozen_string_literal: true

module Playlists
  class GetAllPlaylistsService < ApplicationService
    attr_reader :user_id, :screen_id

    def initialize(user_id = nil, screen_id = nil)
      @user_id = user_id
      @screen_id = screen_id
    end

    def call
      playlists ||= Playlist.where(user_id:, screen_id:).first(50) if user_id.present? && screen_id.present?
      playlists ||= Playlist.where(user_id:).first(50) if user_id.present?
      playlists ||= Playlist.first(50)

      OpenStruct.new(playlists:)
    end
  end
end
