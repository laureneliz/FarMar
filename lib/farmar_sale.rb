require_relative '../farmar.rb'
require 'date'
require_relative './farmar_vendor'
require_relative './farmar_product'

class FarMar::Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

  SALES = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/sales.csv')

  def initialize(hash)
    @id = hash[:id]
    @amount = hash[:amount]
    @purchase_time = hash[:purchase_time]
    @vendor_id = hash[:vendor_id]
    @product_id = hash[:product_id]
  end

  def self.all
    sales = []
    SALES.each do |line|
      sale_hash = {}
      sale_hash[:id] = line[0].to_i
      sale_hash[:amount] = line[1].to_i
      sale_hash[:purchase_time] = DateTime.parse(line[2].to_s)
      sale_hash[:vendor_id] = line[3].to_i
      sale_hash[:product_id] = line[4].to_i
      sales << FarMar::Sale.new(sale_hash)
    end
    return sales
  end

  # called on the class, this method finds a sale by the id given.
  def self.find(id)
    id.class != Fixnum ? raise(ArgumentError) : id

    self.all.each do |sale|
      if sale.id == id
        return sale
      end
    end
  end

  # this method takes a sale, grabs that sale's vendor_id, searches the Vendors by that id, and returns the vendor that made that sale.
  def vendor
    id = self.vendor_id
    found_vendor = FarMar::Vendor.find(id)
    return found_vendor
  end

  # this method takes a Sale, grabs that sale's product_id, searches the Products by that id, and returns the Product that was sold during that Sale.
  def product
    id = self.product_id
    found_product = FarMar::Product.find(id)
    return found_product
  end

  # takes 2 DateTimes and then find all the sales betwen thenm

  def self.between(beginning_time, end_time)
    if beginning_time.class != DateTime && end_time.class != DateTime
      beginning_time = DateTime.parse(beginning_time)
      end_time = DateTime.parse(end_time)
    end

    sales = self.all
    found_sales = []

    sales.each do |sale|
      if sale.purchase_time.between?(beginning_time,end_time)
        found_sales << sale
      end
    end
    return found_sales
  end

end # end of class
