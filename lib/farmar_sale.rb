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

  def self.find(id)
    id.class != Fixnum ? raise(ArgumentError) : id

    self.all.each do |sale|
      if sale.id == id
        return sale
      end
    end
  end

  def vendor
    vendor_variable = nil
    all_vendors = FarMar::Vendor.all
    all_vendors.each do |vendor|
      if vendor.id == self.vendor_id
        vendor_variable = vendor
      end
    end
    return vendor_variable
  end

  def product
    product_variable = nil
    all_products = FarMar::Product.all
    all_products.each do |product|
      if product.id == self.product_id
        product_variable = product
      end
    # break
    end
    return product_variable
  end

end # end of class
