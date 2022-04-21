# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes :id, :user_id
end
