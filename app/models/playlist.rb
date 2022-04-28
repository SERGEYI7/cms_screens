# frozen_string_literal: true

class Playlist < ApplicationRecord
  belongs_to :user
  belongs_to :screen
  validates :name, length: { in: 2..30 }, presence: true
  has_many :contents, dependent: :delete_all
end
