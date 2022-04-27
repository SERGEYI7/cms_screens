# frozen_string_literal: true

module Contents
  class CreateContentService < ApplicationService
    attr_reader :user_id, :playlist_id, :attachment

    def initialize(user_id, playlist_id, attachment)
      @user_id = user_id
      @playlist_id = playlist_id
      @attachment = attachment
    end

    def call
      content = Content.new(user_id:, playlist_id:, attachment:)

      OpenStruct.new(success?: content.save, content:, errors: content.errors.full_messages)
    end
  end
end
