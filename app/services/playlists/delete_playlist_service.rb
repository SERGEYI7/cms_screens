# frozen_string_literal: true

module Playlists
  class DeletePlaylistService < AuthorizedService
    attr_reader :id

    def initialize(current_user:, id:)
      super(current_user:)
      @id = id
    end

    def call
      playlist = current_user.playlists.find_by(id:)

      return OpenStruct.new(success?: false, playlist: nil, errors: ["playlist not found"]) if playlist.blank?

      authorize playlist, :destroy?

      playlist.destroy

      OpenStruct.new(success?: playlist.destroyed?, playlist:, errors: playlist.errors.full_messages)
    end
  end
end
