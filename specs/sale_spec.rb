require_relative 'spec_helper'
require_relative '../lib/farmar_sale'
require_relative '../lib/farmar_vendor'
require 'date'


describe 'testing Sale class and class methods' do

  let(:list_of_sales) { FarMar::Sale.all }
  let(:random_sale) { FarMar::Sale.all.sample }

  it 'sale class should exist' do
    expect(list_of_sales.sample).must_be_instance_of(FarMar::Sale)
  end

  it 'testing data types for attributes' do
    sale = list_of_sales.sample
    unless sale.id.class == NilClass
      expect(sale.id).must_be_instance_of(Fixnum)
    end
    unless sale.amount.class == NilClass
      expect(sale.amount).must_be_instance_of(Fixnum)
    end
    unless sale.purchase_time.class == NilClass
      expect(sale.purchase_time).must_be_instance_of(DateTime)
    end
    unless sale.vendor_id.class == NilClass
      expect(sale.vendor_id).must_be_instance_of(Fixnum)
    end
    unless sale.product_id.class == NilClass
      expect(sale.product_id).must_be_instance_of(Fixnum)
    end
  end

end

describe 'testing Sale class methods' do

  let(:list_of_sales) { FarMar::Sale.all }
  let(:random_sale) { FarMar::Sale.all.sample }
  let(:array) { Array.new }
  let(:time1) { DateTime.new(2013,11,rand(6..13),rand(0..23),rand(0..59),rand(0..59),'-8')}
  let(:time2) { DateTime.new(2013,11,rand(6..13),rand(0..23),rand(0..59),rand(0..59),'-8')}


  ########### self.all method
  it 'self.all should return an array of all sales' do
    expect(list_of_sales).must_be_instance_of(Array)
    expect(list_of_sales.length).must_equal(12798)
  end

  it 'self.all array should contain all sales, including a random sampling of sale ids' do
    list_of_sales.each do |sale|
      array << sale.id
    end
    expect(array).must_include(11389)
    expect(array).must_include(4943)
    expect(array).must_include(990)
    expect(array).must_include(1)
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_sales.sample.all} ).must_raise(NoMethodError)
  end

  it 'self.find(id) must return a sale' do
    # skip
    expect(FarMar::Sale.find(random_sale.id)).must_be_instance_of(FarMar::Sale)
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

  #  self.between(beginning_time, end_time): returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments
  it 'self.between should return an array' do
    if time1 > time2
      expect(FarMar::Sale.between(time2,time1)).must_be_instance_of(Array)
    elsif time2 > time1
      expect(FarMar::Sale.between(time1,time2)).must_be_instance_of(Array)
    end
  end

  it 'array returned from self.between should have Sale objects in it' do
    if time1 > time2
      expect(FarMar::Sale.between(time2,time1).sample).must_be_instance_of(FarMar::Sale)
    elsif time2 > time1
      expect(FarMar::Sale.between(time1,time2).sample).must_be_instance_of(FarMar::Sale)
    end
  end

  it 'self.between should throw ArgError if arguments are not DateTimes or cannot be parsed to DateTimes' do
    expect( proc {FarMar::Sale.between("sghgsed","4ds,nvbsd") }).must_raise(ArgumentError)
    expect( proc {FarMar::Sale.between("sghgsed",["4ds,nvbsd", 30238, 238584023]) }).must_raise(ArgumentError)

  end

end # end of 1st describe

describe ' testing instance methods for Sale class' do
 ########### vendor method

 let(:random_sale) { FarMar::Sale.all.sample }
 let(:not_random_sale) { FarMar::Sale.find(1212) }
 let(:not_random_vendor) { FarMar::Vendor.find(265) }
 let(:not_random_product) { FarMar::Product.find(835)}
 let(:array) { Array.new }

  it 'vendor method should return a vendor' do
    expect(random_sale.vendor).must_be_instance_of(FarMar::Vendor)
  end

  it 'vendor method must return the correct vendor' do
    # the vendor ID is 265 of the not_random_sale.... maybe this will work?
    expect(not_random_sale.vendor.name).must_equal(not_random_vendor.name)
  end

  ########### product method

  it 'product method should return a product' do
    expect(random_sale.product).must_be_instance_of(FarMar::Product)
  end

  it 'product method must return the correct product' do
    expect(not_random_sale.product.name).must_equal(not_random_product.name)
  end

end # end of describe
