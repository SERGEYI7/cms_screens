# frozen_string_literal: true

class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :screen_id
end
