# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable # ,:confirmable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules.
  has_many :events, dependent: :delete_all
  has_many :screens, dependent: :delete_all
  has_many :playlists, dependent: :delete_all
  has_many :contents, dependent: :delete_all
end
