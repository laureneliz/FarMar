require_relative '../farmar.rb'

class FarMar::Product
  attr_reader :id, :name, :vendor_id

  PRODUCTS = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/products.csv')

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @vendor_id = hash[:vendor_id]
  end

  def self.all
    products = []
    PRODUCTS.each do |line|
      product_hash = {}
      product_hash[:id] = line[0].to_i
      product_hash[:name] = line[1]
      product_hash[:vendor_id] = line[2].to_i
      products << FarMar::Product.new(product_hash)
    end
    return products
  end

  def self.find(id)
    id.class != Fixnum ? raise(ArgumentError) : id

    self.all.each do |product|
      if product.id == id
        return product
      end
    end
  end

  # finds the Vendor that sells this Product with the Product's id
  def vendor
    id = self.vendor_id
    found_vendor = FarMar::Vendor.find(id)
    return found_vendor
  end

end
