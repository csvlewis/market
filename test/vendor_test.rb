require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_it_starts_with_an_empty_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    hash = {}
    assert_equal hash, vendor.inventory
  end

  def test_items_start_unstocked
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_it_can_stock_items
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 25)

    assert_equal 55, vendor.check_stock("Peaches")
  end

  def test_stocked_items_are_added_to_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 25)
    vendor.stock("Tomatoes", 12)
    hash = {
      "Peaches"=>55,
      "Tomatoes"=>12
    }

    assert_equal hash, vendor.inventory
  end
end
