# frozen_string_literal: true

class AddPositionToContents < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :position, :integer
  end
end
