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
end
