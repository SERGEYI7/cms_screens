# frozen_string_literal: true

class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.timestamps
    end

    add_reference :playlists, :user, foreign_key: true
    add_reference :playlists, :screen, foreign_key: true
  end
end
