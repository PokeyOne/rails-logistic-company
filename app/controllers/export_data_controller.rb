# typed: strict
# frozen_string_literal: true

class ExportDataController < ApplicationController
  extend T::Sig

  sig { void }
  def index; end

  # TODO: Accept a date range and export all packages in that range.
  sig { returns(T.untyped) }
  def download_csv
    csv_string = ""

    csv_string += Package.csv_header
    Package.find_each do |package|
      csv_string += package.to_csv
    end

    send_data csv_string, filename: "packages.csv"
  end
end
