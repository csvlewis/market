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
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.key?(item) }
  end

  def sorted_item_list
    all_items = @vendors.map { |vendor| vendor.inventory.keys}
    all_items.flatten.uniq.sort
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
      until amount == 0
        @vendors.each do |vendor|
          if vendor.inventory.keys.include?(item)
            if amount > vendor.inventory[item]
              amount -= vendor.inventory[item]
              vendor.inventory[item] = 0
            elsif amount < vendor.inventory[item]
              vendor.inventory[item] -= amount
              amount = 0
            end
          else
            next
          end
        end
      end
      true
    end
  end
end
