require_relative 'spec_helper'
require_relative '../lib/farmar_product'
require_relative '../lib/farmar_vendor'
require_relative '../lib/farmar_sale'

describe 'testing Product class' do

  let(:list_of_products) { FarMar::Product.all }

  it 'product class should exist' do
    expect(list_of_products.sample).must_be_instance_of(FarMar::Product)
  end

  # there is no error handling here for in case the data types are nil. use ||= somewhere?
  it 'testing data types for attributes' do
    expect(list_of_products.sample.id).must_be_instance_of(Fixnum)
    expect(list_of_products.sample.name).must_be_instance_of(String)
    expect(list_of_products.sample.vendor_id).must_be_instance_of(Fixnum)

  end

end # end of 1st describe

describe 'testing Product class methods' do

  let(:list_of_products) { FarMar::Product.all }
  let(:random_product) { FarMar::Product.all.sample}

  it 'self.all should return an array of all products' do
    expect(list_of_products).must_be_instance_of(Array)
    expect(list_of_products.length).must_equal(8193)
  end

  it 'self.all array should contain all products, including a random sampling of product names' do
    # i can't figure out how to do this with a let. :(
    array_of_names = []
    list_of_products.each do |product|
      array_of_names << product.name
    end
    expect(array_of_names.include?("Moaning Honey")).must_equal(true)
    expect(array_of_names.include?("Thoughtless Beets")).must_equal(true)
    expect(array_of_names.include?("Vivacious Apples")).must_equal(true)
    expect(array_of_names.include?("Plain Fish")).must_equal(true)
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_products.sample.all} ).must_raise(NoMethodError)
  end

  it 'self.find(id) must return the correct product name' do
    expect(FarMar::Product.find(random_product.id).name).must_equal(random_product.name)
  end

  it 'self.find(id) must return a a Product' do
    expect(FarMar::Product.find(random_product.id)).must_be_instance_of(FarMar::Product)
  end

  it 'self.find(id) must throw ArgError if a non-fixnum argument is passed' do
    expect( proc { FarMar::Product.find(random_product.name) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Product.find([1,3,40585]) } ).must_raise(ArgumentError)
    # expect( proc { FarMar::Product.find({1: "forty"}) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Product.find(1493.33402382) } ).must_raise(ArgumentError)
  end

  it 'self.find(id) should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_products.sample.find(random_product.id)} ).must_raise(NoMethodError)
  end

end # end of describe for class methods

describe 'testing Product instance methods' do

  let(:random_product) { FarMar::Product.all.sample}
  let(:non_random_product) { FarMar::Product.find(1416)}

 #########vendor: returns the FarMar::Vendor instance that is associated with this vendor using the FarMar::Product vendor_id field
  it 'vendor method returns a Vendor' do
    expect(random_product.vendor).must_be_instance_of(FarMar::Vendor)
  end

  it 'vendor method returns the correct Vendor' do
    expect(non_random_product.vendor.name).must_equal("Luettgen-Koss")
  end

  ################# #sales: returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.

  it 'sales method must return an array' do
    expect(random_product.sales).must_be_instance_of(Array)
  end

  it 'sales method\'s returned array must contain instances of Sale' do
    if random_product.sales.length > 0
      expect(random_product.sales.sample).must_be_instance_of(FarMar::Sale)
    end
  end

  it 'sales method must return the correct sales for a product' do
    non_random_product.sales.each do |sale|
      array << sale.id
    end
    expect(array).must_include(2072)
    expect(array).must_include(2073)
    expect(array).must_include(2074)
  end


end
