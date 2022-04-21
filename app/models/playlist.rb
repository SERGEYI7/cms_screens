# frozen_string_literal: true

class Playlist < ApplicationRecord
  validates :name, length: { in: 2..30 }, presence: true
  belongs_to :user
  belongs_to :screen
  has_many :contents, dependent: :delete_all
end
