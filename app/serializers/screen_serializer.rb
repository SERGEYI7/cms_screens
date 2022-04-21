# frozen_string_literal: true

class ScreenSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id
end
