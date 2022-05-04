# frozen_string_literal: true

module Contents
  class UpdateContentService < ApplicationService
    def call
      content = Content.find_by(id:)

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if content.blank?

      begin
        authorize content, :update?
      rescue
        return OpenStruct.new(success?: false, content: nil, errors: [must be logged in])
      end

      content.update(
        user_id: current_user.id,
        playlist_id:,
        attachment:
      )

      OpenStruct.new(success?: true, content:, errors: content.errors.full_messages)
    end
  end
end
