require './lib/sale'

class Market
  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.key?(item) }
  end

  def sorted_item_list
    @vendors.map { |vendor| vendor.inventory.keys }.flatten.uniq.sort
  end

  def total_inventory
    total_inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        total_inventory[item] += amount
      end
    end
    total_inventory
  end

  def sell(item, amount)
    if total_inventory[item] < amount
      false
    else
      sale = Sale.new(item, amount, @vendors)
      sale.sell
    end
  end
end
