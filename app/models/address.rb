# A stored address
class Address < ApplicationRecord
  # fields:
  #   line_one
  #   line_two
  #   city
  #   country
  #   region
  #   postal_code
  has_many :packages

  validates :line_one, presence: true, length: { maximum: 255, minimum: 1 }
  validates :line_two, length: { maximum: 255, minimum: 0 }
  validates :city, presence: true, length: { maximum: 255, minimum: 1 }
  validates :country, presence: true, length: { maximum: 255, minimum: 1 }
  validates :region, length: { maximum: 255, minimum: 0 }
  validates :postal_code, length: { maximum: 255, minimum: 0 }

  # The address as a single lined string
  #
  # @return [String] the address as a single lined string
  def one_liner
    addr = "#{line_one}"
    addr << ", #{line_two}" unless line_two.blank?
    "#{addr}, #{city}, #{region}, #{postal_code}, #{country}"
  end

  # The full address over three or four lines. Three lines if line two is empty,
  # four lines if line two is not empty.
  #
  # Example:
  #   123 Main St.
  #   Suite 1
  #   Somewhere, CA 90210
  #   USA
  #
  # @return [[String]] the full address over three or four lines as an array
  def full_address_lines
    addr_lines = [line_one]
    addr_lines << line_two unless line_two.blank?
    addr_lines << "#{city}, #{region} #{postal_code}"
    addr_lines << country.upcase
  end
end
