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

  # searches all sales to find the sales where the product was sold.
  def sales
    found_sales = []
    product_id = self.id
    FarMar::Sale.all.each do |sale|
      if sale.product_id == product_id
        found_sales << sale
      end
    end
    return found_sales
  end

  def number_of_sales
    sales_array = sales
    return sales_array.length
  end

  # returns list of all Products that are associated with a given vendor by searching Products for a given vendor id.
  def self.by_vendor(vendor_id)
    raise ArgumentError unless vendor_id.class == Fixnum

    products = self.all
    found_products = []

    products.each do |product|
      if product.vendor_id == vendor_id
        found_products << product
      end
    end
    return found_products
  end


end # end of class
