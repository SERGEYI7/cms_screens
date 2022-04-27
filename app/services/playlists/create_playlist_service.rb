# frozen_string_literal: true

module Playlists
  class CreatePlaylistService < ApplicationService
    attr_reader :name, :user_id, :screen_id

    def initialize(name, user_id, screen_id)
      @name = name
      @user_id = user_id
      @screen_id = screen_id
    end

    def call
      playlist = Playlist.new(name:, user_id:, screen_id:)

      OpenStruct.new(success?: playlist.save, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
