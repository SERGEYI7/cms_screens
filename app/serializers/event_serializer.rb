# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id
end
