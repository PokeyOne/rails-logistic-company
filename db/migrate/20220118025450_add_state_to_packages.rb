# frozen_string_literal: true

class AddStateToPackages < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :state, :string, default: "information_recieved", null: false
  end
end
