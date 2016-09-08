require_relative 'spec_helper'
require_relative '../lib/farmar_sale'
require 'date'

describe 'testing Sale class' do

  let(:list_of_sales) { FarMar::Sale.all }
  let(:random_sale) { FarMar::Sale.all.sample}
  let(:not_random_sale) { FarMar::Sale.find(1212)}

  it 'sale class should exist' do
    expect(list_of_sales.sample).must_be_instance_of(FarMar::Sale)
  end

  it 'SALES constant should exist' do
    skip
    expect(FarMar::Sale.SALES).must_be_instance_of(Array)
  end


########### self.all method

  # there is no error handling here for in case the data types are nil. use ||= somewhere?
  it 'testing data types for attributes' do
    expect(list_of_sales.sample.id).must_be_instance_of(Fixnum)
    expect(list_of_sales.sample.amount).must_be_instance_of(Fixnum)
    expect(list_of_sales.sample.purchase_time).must_be_instance_of(String)
    expect(list_of_sales.sample.vendor_id).must_be_instance_of(Fixnum)
    expect(list_of_sales.sample.product_id).must_be_instance_of(Fixnum)

  end

  it 'self.all should return an array of all sales' do
    expect(list_of_sales).must_be_instance_of(Array)
    expect(list_of_sales.length).must_equal(12798)
  end

  it 'self.all array should contain all sales, including a random sampling of sale ids' do
    # i can't figure out how to do this with a let. :(
    array_of_ids = []
    list_of_sales.each do |sale|
      array_of_ids << sale.id
    end
    expect(array_of_ids).must_include(11389)
    expect(array_of_ids).must_include(4943)
    expect(array_of_ids).must_include(990)
    expect(array_of_ids).must_include(1)
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_sales.sample.all} ).must_raise(NoMethodError)
  end

########### self.find method

  # it 'self.find(id) must return the sale with that id' do
  #   # skip
  #   expect(FarMar::Sale.find(random_sale.id)).must_equal(random_sale)
  # end

  it 'self.find(id) must return the amount of the sale' do
    # skip
    expect(FarMar::Sale.find(random_sale.id)).must_equal(random_sale.amount)
  end

  it 'self.find(id) must throw ArgError if a non-fixnum argument is passed' do
    # skip
    expect( proc { FarMar::Sale.find("laurenEFB") } ).must_raise(ArgumentError)
    expect( proc { FarMar::Sale.find([1,3,40585]) } ).must_raise(ArgumentError)
    # expect( proc { FarMar::Sale.find({1: "forty"}) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Sale.find(1493.33402382) } ).must_raise(ArgumentError)
  end

  it 'self.find(id) should be a class method, and thus raise method error if called on an instance' do
    # skip
    expect( proc {list_of_sales.sample.find(random_sale.id)} ).must_raise(NoMethodError)
  end

########### vendor method

  it 'vendor method should return a vendor' do
    expect(random_sale.vendor).must_be_instance_of(FarMar::Vendor)
  end

  it 'vendor method should only return one vendor' do
    expect(random_sale.vendor.to_a.length).must_equal(1)
  end

  it 'vendor method must return the correct vendor' do
    # the vendor ID is 265 of the not_random_sale.... maybe this will work?
    expect(not_random_sale.vendor).must_equal(FarMar::Vendor.find(265))
  end

end # end of describe
