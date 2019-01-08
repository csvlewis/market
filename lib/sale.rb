class Sale
  attr_reader :item,
              :amount,
              :vendors
  def initialize(item, amount, vendors)
    @item = item
    @amount = amount
    @vendors = vendors
  end

  def sell
    until @amount.zero?
      @vendors.each do |vendor|
        check_inventory(vendor)
      end
    end
    true
  end

  def check_inventory(vendor)
    remove_items(vendor) if vendor.inventory.key?(@item)
  end

  def remove_items(vendor)
    if @amount > vendor.inventory[@item]
      @amount -= vendor.inventory[@item]
      vendor.inventory[@item] = 0
    elsif @amount < vendor.inventory[@item]
      vendor.inventory[@item] -= @amount
      @amount = 0
    end
  end
end
