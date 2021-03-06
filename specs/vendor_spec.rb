require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'
require_relative '../lib/farmar_market'

describe 'testing Vendor class' do

  let(:list_of_vendors) { FarMar::Vendor.all }

  it 'Vendor class should exist' do
    expect(list_of_vendors.sample).must_be_instance_of(FarMar::Vendor)
  end

  it 'testing data types for attributes' do
    unless list_of_vendors.sample.id.class == NilClass
      expect(list_of_vendors.sample.id).must_be_instance_of(Fixnum)
    end
    unless list_of_vendors.sample.name.class == NilClass
      expect(list_of_vendors.sample.name).must_be_instance_of(String)
    end
    unless list_of_vendors.sample.num_employees.class == NilClass
      expect(list_of_vendors.sample.num_employees).must_be_instance_of(Fixnum)
    end
    unless list_of_vendors.sample.market_id.class == NilClass
      expect(list_of_vendors.sample.market_id).must_be_instance_of(Fixnum)
    end
  end

end

describe 'testing required Vendor class methods' do

  let(:list_of_vendors) { FarMar::Vendor.all }
  let(:random_vendor) { FarMar::Vendor.all.sample }
  let(:random_market) { FarMar::Market.all.sample }
  let(:vendors_by_market) { FarMar::Vendor.by_market(random_market.id)}
  let(:non_random_market) { FarMar::Market.find(300)}
  let(:array) { Array.new }


  it 'self.all should return an array of all vendors' do
    expect(list_of_vendors).must_be_instance_of(Array)
    expect(list_of_vendors.length).must_equal(2690)
  end

  it 'it self.all array should contain all vendors, including a random sampling of vendor names' do
    # i can't figure out how to do this with a let. :(
    array_of_names = []
    list_of_vendors.each do |vendor|
      array_of_names << vendor.name
    end
    expect(array_of_names.include?("Lockman, Gleason and Hettinger")).must_equal(true)
    expect(array_of_names.include?("Tremblay, Casper and Heidenreich")).must_equal(true)
    expect(array_of_names.include?("Leffler Group")).must_equal(true)
    expect(array_of_names.include?("Muller, Hansen and Lakin")).must_equal(true)
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_vendors.sample.all} ).must_raise(NoMethodError)
  end

  it 'self.find(id) must return a Vendor' do
    expect(FarMar::Vendor.find(random_vendor.id)).must_be_instance_of(FarMar::Vendor)
  end

  it 'self.find(id) should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_vendors.sample.find(random_vendor.id)} ).must_raise(NoMethodError)
  end

  it 'self.find(id) must throw ArgError if a non-fixnum argument is passed' do
    expect( proc { FarMar::Vendor.find(random_vendor.name) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Vendor.find([1,3,40585]) } ).must_raise(ArgumentError)
    # expect( proc { FarMar::Market.find({1: "forty"}) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Vendor.find(1493.33402382) } ).must_raise(ArgumentError)
  end

  #################self.by_market(market_id): returns all of the vendors with the given market_id

  it 'self.by_market(market_id) method should only take a Fixnum as an arugment, else should throw an ArgError' do
    expect( proc { FarMar::Vendor.by_market(random_vendor.name) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Vendor.by_market([1,3,40585]) } ).must_raise(ArgumentError)
    # expect( proc { FarMar::Market.find({1: "forty"}) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Vendor.by_market(1493.33402382) } ).must_raise(ArgumentError)
  end

  it 'self.by_market(market_id) method returns an array' do
    expect(vendors_by_market).must_be_instance_of(Array)
  end

  it 'self.by_market(market_id) should have vendors in its array' do
    expect(vendors_by_market.sample).must_be_instance_of(FarMar::Vendor)
  end

  it 'self.by_market(market_id) must return the correct vendors' do
    FarMar::Vendor.by_market(non_random_market.id).each do |vendor|
      array << vendor.name
    end
    expect(array).must_include("Gibson Group")
  end

end # end of class methods search

describe 'testing required Vendor instance methods ' do
  ############ market method
  let(:random_vendor) { FarMar::Vendor.all.sample }
  let(:not_random_vendor) { FarMar::Vendor.find( 1804 )}
  let(:not_random_market) { FarMar::Market.find(338)}
  let(:array) { Array.new }

  it 'market method should return a market' do
    expect(random_vendor.market).must_be_instance_of(FarMar::Market)
  end

  it 'market method must return the correct market' do
    expect(not_random_vendor.market.name).must_equal(not_random_market.name)
  end

  ######## products method
  ##products: returns a collection of FarMar::Product instances that are associated by the FarMar::Product vendor_id field.

  it 'products must return an array' do
    expect(random_vendor.products).must_be_instance_of(Array)
  end

  it 'the elements of the array products returns must be Products' do
    expect(random_vendor.products.sample).must_be_instance_of(FarMar::Product)
  end

  it 'the products method must return the correct products' do
    not_random_vendor.products.each do |product|
      array << product.name
    end
    expect(array).must_include("Young Pretzel")
    expect(array).must_include("Roasted Burrito")
  end


  #### sales method #sales: returns a collection of FarMar::Sale instances that are associated by the vendor_id field.

  it 'sales must return an array' do
    expect(random_vendor.sales).must_be_instance_of(Array)
  end

  it 'the elements of the array sales returns must be Sales' do
    if random_vendor.sales.length > 0
      expect(random_vendor.sales.sample).must_be_instance_of(FarMar::Sale)
    end
  end

  it 'the sales method must return the correct sales' do
    not_random_vendor.sales.each do |sale|
      array << sale.id
    end
    expect(array).must_include(8073)
    expect(array).must_include(8077)
    expect(array).must_include(8080)
  end

  ####### revenue method
  #revenue: returns the the sum of all of the vendor's sales (in cents)


  it 'revenue method must return a fixnum' do
    expect(random_vendor.revenue).must_be_instance_of(Fixnum)
  end

  it 'revenue method must be the correct amount of revenue' do
    expect(not_random_vendor.revenue).must_equal(43742)
  end

end # end of describe

describe 'testing optional Vendor methods' do

  let(:fixnum) { rand(0..100) }
  let(:highest_selling_vendors) { FarMar::Vendor.most_revenue(fixnum) }

  #### self.most_revenue(n)
  it 'most_revenue must take a fixnum as an argument' do
    skip
    expect( proc {FarMar::Vendor.most_revenue(403923.45923)} ).must_raise(ArgumentError)
    expect( proc {FarMar::Vendor.most_revenue([2,5,7,4,46])} ).must_raise(ArgumentError)
    expect( proc {FarMar::Vendor.most_revenue("hello this is a string")} ).must_raise(ArgumentError)
  end

  it 'most_revenue must return an array of arrays' do
    skip
    expect(highest_selling_vendors).must_be_instance_of(Array)
    expect(highest_selling_vendors.sample).must_be_instance_of(Array)
  end

  it 'first element of 2d array must be a Vendor, second element must be a fixnum' do
    skip
    expect(highest_selling_vendors.sample[0]).must_be_instance_of(FarMar::Vendor)
    expect(highest_selling_vendors.sample[1]).must_be_instance_of(Fixnum)
  end

  #### self.most_items(n)


  ##### self.revenue(date)


  ##### revenue (date)


end # end of describe
