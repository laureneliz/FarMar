require_relative 'spec_helper'
require_relative '../lib/farmar_market'


describe 'testing Market class and class methods' do

  let(:list_of_markets) { FarMar::Market.all }

  it 'market class should exist' do
    expect(list_of_markets.sample).must_be_instance_of(FarMar::Market)
  end

  # there is no error handling here for in case the data types are nil. use ||= somewhere?
  it 'testing data types for attributes' do
    market = list_of_markets.sample
    unless market.id.class == NilClass
      expect(market.id).must_be_instance_of(Fixnum)
    end
    unless market.name.class == NilClass
      expect(market.name).must_be_instance_of(String)
    end
    unless market.address.class == NilClass
      expect(market.address).must_be_instance_of(String)
    end
    unless market.city.class == NilClass
      expect(market.city).must_be_instance_of(String)
    end
    unless market.county.class == NilClass
      expect(market.county).must_be_instance_of(String)
    end
    unless market.state.class == NilClass
      expect(market.state).must_be_instance_of(String)
    end
    unless market.zip.class == NilClass
      expect(market.zip).must_be_instance_of(String)
    end
  end

end # end of describe

describe 'testing Market class methods' do
  let(:list_of_markets) { FarMar::Market.all }
  let(:random_market) { FarMar::Market.all.sample}
  let (:array) { Array.new }

  ########### self.all method

  it 'self.all should return an array of all markets' do
    expect(list_of_markets).must_be_instance_of(Array)
    expect(list_of_markets.length).must_equal(500)
  end

  it 'self.all array should contain all markets, including a random sampling of market names' do
    # i can't figure out how to do this with a let. :(
    list_of_markets.each do |market|
      array << market.name
    end
    expect(array).must_include("People's Co-op Farmers Market")
    expect(array).must_include("Medford Farmers Market")
    expect(array).must_include("Scripps Ranch Farmers Market & Family Festival")
    expect(array).must_include("Warren Farmers Market")
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_markets.sample.all} ).must_raise(NoMethodError)
  end

 ########### self.find method

  it 'self.find(id) must return a market' do
    expect(FarMar::Market.find(random_market.id)).must_be_instance_of(FarMar::Market)
  end

  it 'self.find(id) must throw ArgError if a non-fixnum argument is passed' do
    expect( proc { FarMar::Market.find(random_market.name) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Market.find([1,3,40585]) } ).must_raise(ArgumentError)
    # expect( proc { FarMar::Market.find({1: "forty"}) } ).must_raise(ArgumentError)
    expect( proc { FarMar::Market.find(1493.33402382) } ).must_raise(ArgumentError)
  end

  it 'self.find(id) should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_markets.sample.find(random_market.id)} ).must_raise(NoMethodError)
  end

end # end of  describe

describe 'testing Market instance methods' do

  let(:random_market) { FarMar::Market.all.sample}
  let(:non_random_market) {FarMar::Market.find(69)}

 ########### vendors method

  it 'vendors method should return an array' do
    expect(random_market.vendors).must_be_instance_of(Array)
  end

  it 'vendors method\'s returned array must contain Vendor objects' do
    expect(random_market.vendors.sample).must_be_instance_of(FarMar::Vendor)
  end

  it 'vendors method must return the correct vendors for a market' do
    array_of_vendor_names = []
    non_random_market.vendors.each do |vendor|
      array_of_vendor_names << vendor.name
    end
    expect(non_random_market.vendors.length).must_equal(10)
    expect(array_of_vendor_names).must_include("Pagac, Langosh and Bogan")
    expect(array_of_vendor_names).must_include("Schaden Group")
  end

end # end of describe
