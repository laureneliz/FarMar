require_relative 'spec_helper'
require_relative '../lib/farmar_market'


describe 'testing market class' do

  let(:list_of_markets) {FarMar::Market.all }

  it 'MARKETS constant should exist' do

  end

  it 'market class should exist' do
    expect(list_of_markets.sample).must_be_instance_of(FarMar::Market)
  end

  # there is no error handling here for in case the data types are nil. use ||= somewhere?
  it 'testing data types for attributes' do
    expect(list_of_markets.sample.id).must_be_instance_of(Fixnum)
    expect(list_of_markets.sample.name).must_be_instance_of(String)
    expect(list_of_markets.sample.address).must_be_instance_of(String)
    expect(list_of_markets.sample.city).must_be_instance_of(String)
    expect(list_of_markets.sample.county).must_be_instance_of(String)
    expect(list_of_markets.sample.state).must_be_instance_of(String)
    expect(list_of_markets.sample.zip).must_be_instance_of(String)
  end

  it 'self.all should return an array of all markets' do
    expect(FarMar::Market.all).must_be_instance_of(Array)
    expect(FarMar::Market.all.length).must_equal(500)
  end

  it 'self.all array should contain all markets, including a random sampling of market names' do
    # i can't figure out how to do this with a let. :(
    array_of_names = []
    list_of_markets.each do |market|
      array_of_names << market.name
    end
    expect(array_of_names.include?("People's Co-op Farmers Market")).must_equal(true)
    expect(array_of_names.include?("Medford Farmers Market")).must_equal(true)
    expect(array_of_names.include?("Scripps Ranch Farmers Market & Family Festival")).must_equal(true)
    expect(array_of_names.include?("Warren Farmers Market")).must_equal(true)
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_markets.sample.all} ).must_raise(NoMethodError)
  end

  it 'self.find(id) must return the correct market name' do
    random_market = FarMar::Market.all.sample
    expect(FarMar::Market.find(random_market.id)).must_equal(random_market.name)
  end


end # end of describe
