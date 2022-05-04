# frozen_string_literal: true

module Contents
  class CreateContentService < ApplicationService
    def call
      content = Content.new(user_id: current_user.id, playlist_id:, attachment:)
      authorize content, :create?

      OpenStruct.new(success?: content.save, content:, errors: content.errors.full_messages)
    end
  end
end
