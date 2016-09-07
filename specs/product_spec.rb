require_relative 'spec_helper'
require_relative '../lib/farmar_product'

describe 'testing Product class' do

  let(:list_of_products) { FarMar::Product.all }
  let(:random_product) { FarMar::Product.all.sample}

  it 'product class should exist' do
    expect(list_of_products.sample).must_be_instance_of(FarMar::Product)
  end

  it 'PRODUCTS constant should exist' do
    skip
    expect(FarMar::Product.PRODUCTS).must_be_instance_of(Array)
  end

  # there is no error handling here for in case the data types are nil. use ||= somewhere?
  it 'testing data types for attributes' do
    expect(list_of_products.sample.id).must_be_instance_of(Fixnum)
    expect(list_of_products.sample.name).must_be_instance_of(String)
    expect(list_of_products.sample.vendor_id).must_be_instance_of(Fixnum)

  end

  it 'self.all should return an array of all products' do
    expect(list_of_products).must_be_instance_of(Array)
    expect(list_of_products.length).must_equal(500)
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
    expect(FarMar::Product.find(random_product.id)).must_equal(random_product.name)
  end

  it 'self.find(id) must return a string' do
    expect(FarMar::Product.find(random_product.id)).must_be_instance_of(String)
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

end # end of describe
