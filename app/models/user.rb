# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable # ,:confirmable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules.
  validates :name, length: { in: 2..30 }, presence: true
  has_many :events, dependent: :delete_all
  has_many :screens, dependent: :delete_all
  has_many :playlists, dependent: :delete_all
  has_many :contents, dependent: :delete_all
end
