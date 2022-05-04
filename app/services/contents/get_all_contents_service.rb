# frozen_string_literal: true

module Contents
  class GetAllContentsService < ApplicationService
    def call
      if current_user.present? && playlist_id.present?
        contents ||= Content.where(user_id: current_user.id,
                                   playlist_id:).first(50)
      end
      contents ||= Content.where(user_id: current_user.id).first(50) if current_user.present?
      contents ||= Content.first(50)

      return OpenStruct.new(success?: false, contents: nil, errors: ["Events not found"]) if contents.blank?

      begin
        authorize contents[0], :index?
      rescue StandardError
        return OpenStruct.new(success?: false, contents: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, contents:)
    end
  end
end
