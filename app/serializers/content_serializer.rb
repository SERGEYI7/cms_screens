# frozen_string_literal: true

class ContentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :playlist_id, :attachment
end
