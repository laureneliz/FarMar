require_relative '../farmar.rb'
require 'awesome_print'
require_relative 'farmar_market'
require_relative 'farmar_product'

class FarMar::Vendor
  attr_reader :id, :name, :num_employees, :market_id

VENDORS = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/vendors.csv')

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @num_employees = hash[:num_employees]
    @market_id = hash[:market_id].to_i
  end

  def self.all
    vendors = []
    VENDORS.each do |line|
      vendor_hash = {}
      vendor_hash[:id] = line[0].to_i
      vendor_hash[:name] = line[1]
      vendor_hash[:num_employees] = line[2].to_i
      vendor_hash[:market_id] = line[3].to_i
      vendors << FarMar::Vendor.new(vendor_hash)
    end
    return vendors
  end

  # this method called on the class Vendor, finds a particular Vendor with the ID it is given.
  def self.find(id)
    id.class != Fixnum ? raise(ArgumentError) : id

    self.all.each do |vendor|
      if vendor.id == id
        return vendor
      end
    end
  end

  # this method finds the Market that a Vendor sells at and returns it.
  def market
    id = self.market_id
    found_market = FarMar::Market.find(id)
    return found_market
  end

  # this method searches the Products for instances that match this Vendor and shovels them into an array.
  def products
    found_products = []
    vendor_id = self.id
    FarMar::Product.all.each do |product|
      if product.vendor_id == vendor_id
        found_products << product
      end
    end
    return found_products
  end

  def sales
    found_sales = []
    vendor_id = self.id
    FarMar::Sale.all.each do |sale|
      if sale.vendor_id == vendor_id
        found_sales << sale
      end
    end
    return found_sales
  end

end # end of Vendor
