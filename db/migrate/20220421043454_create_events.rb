# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name

      t.timestamps
    end

    add_reference :events, :user, foreign_key: true
  end
end
