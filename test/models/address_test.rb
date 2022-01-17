require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "should not validate address with blank first line" do
    address = Address.new(line_one: "", line_two: "Suite 101", city: "Vancouver", country: "CANADA", region: "BC", postal_code: "A1B2C3")
    assert_not address.valid?
  end
end
