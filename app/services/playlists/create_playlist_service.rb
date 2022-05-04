# frozen_string_literal: true

module Playlists
  class CreatePlaylistService < ApplicationService
    def call
      playlist = Playlist.new(name:, user_id: current_user.id, screen_id:)
      authorize playlist, :create?

      OpenStruct.new(success?: playlist.save, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
