# The base unit of the business. This represents everything that is shipped.
class Package < ApplicationRecord
  belongs_to :from_address, class_name: "Address"
  belongs_to :to_address, class_name: "Address"
end
