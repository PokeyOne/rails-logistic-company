# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :country
      t.string :region
      t.string :postal_code

      t.timestamps
    end

    # Add from and to fields to the packages table
    add_reference :packages, :to_address, foreign_key: { to_table: :addresses }
    add_reference :packages, :from_address, foreign_key: { to_table: :addresses }
  end
end
