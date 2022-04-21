# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :events
  has_many :screens
  has_many :playlists
  has_many :contents
end
