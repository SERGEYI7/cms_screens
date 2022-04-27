# frozen_string_literal: true

module Contents
  class GetAllContentsService < ApplicationService
    attr_reader :user_id, :playlist_id

    def initialize(user_id = nil, playlist_id = nil)
      @user_id = user_id
      @playlist_id = playlist_id
    end

    def call
      contents ||= Content.where(user_id:, playlist_id:).first(50) if user_id.present? && playlist_id.present?
      contents ||= Content.where(user_id:).first(50) if user_id.present?
      contents ||= Content.first(50)
      OpenStruct.new(contents:)
    end
  end
end
