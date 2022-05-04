# frozen_string_literal: true

module Playlists
  class GetAllPlaylistsService < ApplicationService
    def call
      if current_user.present? && screen_id.present?
        playlists ||= Playlist.where(user_id: current_user.id,
                                     screen_id:).first(50)
      end
      playlists ||= Playlist.where(user_id: current_user.id).first(50) if current_user.present?
      playlists ||= Playlist.first(50)

      return OpenStruct.new(success?: false, playlists: nil, errors: ["Playlists not found"]) if playlists.blank?

      begin
        authorize playlists[0], :index?
      rescue StandardError
        return OpenStruct.new(success?: false, playlists: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, playlists:)
    end
  end
end
