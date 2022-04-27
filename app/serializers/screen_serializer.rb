# frozen_string_literal: true

class ScreenSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :event_id
end
