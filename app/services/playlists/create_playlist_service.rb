# frozen_string_literal: true

module Playlists
  class CreatePlaylistService < AuthorizedService
    attr_reader :name, :screen_id

    def initialize(current_user:, name:, screen_id:)
      super(current_user:)
      @name = name
      @screen_id = screen_id
    end

    def call
      playlist = current_user.playlists.new(name:, screen_id:)

      OpenStruct.new(success?: playlist.save, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
