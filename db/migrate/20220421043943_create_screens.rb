# frozen_string_literal: true

class CreateScreens < ActiveRecord::Migration[7.0]
  def change
    create_table :screens do |t|
      t.string :name

      t.timestamps
    end

    add_reference :screens, :user, foreign_key: true
    add_reference :screens, :event, foreign_key: true
  end
end
