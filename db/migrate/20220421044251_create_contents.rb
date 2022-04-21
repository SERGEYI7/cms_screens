# frozen_string_literal: true

class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.text :attachment

      t.timestamps
    end

    add_reference :contents, :user, foreign_key: true
    add_reference :contents, :playlist, foreign_key: true
  end
end
