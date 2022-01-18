require "test_helper"

class PackageTest < ActiveSupport::TestCase
  test "should not save a package with a bogus state" do
    package = Package.last
    package.state = "bogus"
    assert_not package.save
  end

  test "csv should be properly formatted" do
    package = Package.find(1)
    address_one = Address.find(1)
    address_two = Address.find(2)
    expected = "1,Test Package,in_trasit,\"#{address_one.one_liner}\",\"#{address_two.one_liner}\"\n"
    assert_equal expected, package.to_csv
  end
end
