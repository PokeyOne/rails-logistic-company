# frozen_string_literal: true

class ExportDataController < ApplicationController
  def index; end

  # TODO: Accept a date range and export all packages in that range.
  def download_csv
    csv_string = ""

    csv_string += Package.csv_header
    Package.find_each do |package|
      csv_string += package.to_csv
    end

    send_data csv_string, filename: "packages.csv"
  end
end
