# frozen_string_literal: true

module Playlists
  class GetAllPlaylistsService < AuthorizedService
    attr_reader :screen_id

    def initialize(current_user:, screen_id:)
      super(current_user:)
      @screen_id = screen_id
    end

    def call
      playlists ||= current_user.playlists.where(screen_id:).first(50) if screen_id.present?
      playlists ||= current_user.playlists.first(50)

      OpenStruct.new(success?: true, playlists:)
    end
  end
end
