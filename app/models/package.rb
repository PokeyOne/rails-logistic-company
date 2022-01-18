# The base unit of the business. This represents everything that is shipped.
class Package < ApplicationRecord
  STATES = %w(
    information_recieved
    in_transit
    delivered
    returned
    cancelled
  ).freeze

  belongs_to :from_address, class_name: "Address"
  belongs_to :to_address, class_name: "Address"

  validates :state, presence: true, inclusion: { in: STATES }

  # Convert the package to CSV format as a single row.
  def to_csv
    "#{name},#{state},\"#{from_address.one_liner}\",\"#{to_address.one_liner}\"\n"
  end

  # The header row for the CSV file.
  def self.csv_header
    "name,state,from_address,to_address\n"
  end
end
