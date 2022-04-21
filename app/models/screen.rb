# frozen_string_literal: true

class Screen < ApplicationRecord
  validates :name, length: { in: 2..30 }, presence: true
  belongs_to :user
  belongs_to :event
  has_many :playlists, dependent: :delete_all
end
