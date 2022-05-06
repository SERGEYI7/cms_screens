# frozen_string_literal: true

module Playlists
  class UpdatePlaylistService < AuthorizedService
    attr_reader :id, :name, :screen_id

    def initialize(current_user:, id:, name:, screen_id:)
      super(current_user:)
      @id = id
      @name = name
      @screen_id = screen_id
    end

    def call
      playlist = current_user.playlists.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      authorize playlist, :update?

      playlist.update(name:, screen_id:)

      OpenStruct.new(success?: true, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
