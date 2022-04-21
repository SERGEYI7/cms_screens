# frozen_string_literal: true

class Screen < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :playlists, dependent: :delete_all
  validates :name, length: { in: 2..30 }, presence: true
end
