# frozen_string_literal: true

require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "should not validate address with blank first line" do
    address = Address.new(line_one: "", line_two: "Suite 101", city: "Vancouver", country: "CANADA", region: "BC",
                          postal_code: "A1B2C3")
    assert_not address.valid?
  end

  test "address one liner with no line two" do
    address = Address.new(line_one: "123 Main St.", line_two: "", city: "Somewhere", country: "USA", region: "CA",
                          postal_code: "90210")
    assert_equal "123 Main St., Somewhere, CA, 90210, USA", address.one_liner
  end

  test "address one liner with line two" do
    address = Address.new(line_one: "123 Main St.", line_two: "Suite 101", city: "Somewhere", country: "USA",
                          region: "CA", postal_code: "90210")
    assert_equal "123 Main St., Suite 101, Somewhere, CA, 90210, USA", address.one_liner
  end
end
