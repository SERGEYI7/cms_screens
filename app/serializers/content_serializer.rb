# frozen_string_literal: true

class ContentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :position, :playlist_id, :attachment
end
