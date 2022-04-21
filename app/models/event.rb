# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_many :screens, dependent: :delete_all
  validates :name, length: { in: 2..30 }, presence: true
end
