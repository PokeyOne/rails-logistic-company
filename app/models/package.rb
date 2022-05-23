# The base unit of the business. This represents everything that is shipped.
class Package < ApplicationRecord
  STATES = %w[
    information_recieved
    in_transit
    delivered
    returned
    cancelled
  ].freeze

  # These hooks are here so that if this is the only package that references
  # an address, the address is deleted.
  before_destroy :stash_addresses_for_deletion
  after_destroy :delete_addresses

  belongs_to :from_address, class_name: "Address"
  belongs_to :to_address, class_name: "Address"
  accepts_nested_attributes_for :to_address, :from_address

  validates :state, presence: true, inclusion: { in: STATES }
  validates :name, presence: true
  validates :from_address, presence: true
  validates :to_address, presence: true

  # TODO: Add a scope for packages in active states (information_recieved,
  #       or in_transit)

  # TODO: Method: active?

  # TODO: Constant array of active states.

  # TODO: Have an updates object so a package can be tracked to different
  #       locations.

  # Convert the package to CSV format as a single row.
  def to_csv
    "#{id},#{name},#{state},\"#{from_address.one_liner}\",\"#{to_address.one_liner}\"\n"
  end

  # The header row for the CSV file.
  def self.csv_header
    "id,name,state,from_address,to_address\n"
  end

  private

  # Stash the addresses for deletion.
  #
  # This is done so that the addresses can be deleted after the package is
  # destroyed (if they don't have any packages).
  def stash_addresses_for_deletion
    @from_address = from_address
    @to_address = to_address
  end

  # Delete the addresses if they don't have any packages attached.
  def delete_addresses
    @from_address.destroy if @from_address.all_packages.empty?
    @to_address.destroy if @to_address.all_packages.empty?
  end
end
