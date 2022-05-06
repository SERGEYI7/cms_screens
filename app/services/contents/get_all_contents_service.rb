# frozen_string_literal: true

module Contents
  class GetAllContentsService < AuthorizedService
    attr_reader :playlist_id

    def initialize(playlist_id:, current_user:)
      super(current_user:)
      @playlist_id = playlist_id
    end

    def call
      contents ||= current_user.contents.where(playlist_id:).first(50) if playlist_id.present?
      contents ||= current_user.contents.first(50)

      OpenStruct.new(success?: true, contents:)
    end
  end
end
