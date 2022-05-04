# frozen_string_literal: true

module Contents
  class GetContentService < ApplicationService
    def call
      var_find_content = find_content

      return OpenStruct.new(success?: false, content: nil, errors: ["content not found"]) if var_find_content.blank?

      begin
        authorize var_find_content, :show?
      rescue StandardError
        return OpenStruct.new(success?: false, content: nil, errors: ["must be logged in"])
      end

      OpenStruct.new(success?: true, content: find_content, errors: nil)
    end

    private

    def find_content
      if current_user.present? && playlist_id.present?
        return Content.find_by(id:, user_id: current_user.id,
                               playlist_id:)
      end
      return Content.find_by(id:, user_id: current_user.id) if current_user.present?

      Content.find_by(id:)
    end
  end
end
