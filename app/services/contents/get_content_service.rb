# frozen_string_literal: true

module Contents
  class GetContentService < ApplicationService
    attr_reader :id, :user_id, :playlist_id

    def initialize(id, user_id = nil, playlist_id = nil)
      @id = id
      @user_id = user_id
      @playlist_id = playlist_id
    end

    def call
      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if find_content.blank?

      OpenStruct.new(success?: true, content: find_content, errors: nil)
    end

    private

    def find_content
      return Content.find_by(id:, user_id:, playlist_id:) if user_id.present? && playlist_id.present?
      return Content.find_by(id:, user_id:) if user_id.present?

      Content.find_by(id:)
    end
  end
end
