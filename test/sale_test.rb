require 'minitest/autorun'
require 'minitest/pride'
require './lib/sale'
require './lib/vendor'

class SaleTest < Minitest::Test
  def test_it_exists
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendors = [vendor_1, vendor_2, vendor_3]
    sale = Sale.new("Peaches", 10, vendors)

    assert_instance_of Sale, sale
  end

  def test_it_has_attributes
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendors = [vendor_1, vendor_2, vendor_3]
    sale = Sale.new("Peaches", 10, vendors)

    assert_equal "Peaches", sale.item
    assert_equal 10, sale.amount
    assert_equal [vendor_1, vendor_2, vendor_3], sale.vendors
  end

  def test_amount_is_zero_after_selling
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    vendors = [vendor_1, vendor_2, vendor_3]
    sale = Sale.new("Peaches", 10, vendors)
    sale.sell

    assert_equal 0, sale.amount
  end
end
