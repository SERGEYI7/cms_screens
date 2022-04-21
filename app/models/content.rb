# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :user
  belongs_to :playlist
end
