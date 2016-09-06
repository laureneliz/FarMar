require_relative 'spec_helper'
require_relative '../lib/farmar_market'


describe 'testing market class' do

  list_of_markets = FarMar::Market.read_in_csv('//Users/laurenfries/ada/week-5/farmar/support/markets.csv')
  # # manual_list_of_markets = [FarMar::Market.new({id: 30238, name: "Blue", city: "Superior"}),
  #                         FarMar::Market.new({id: 40924, name: "Cat", city: "Tracktown"}),
  #                         FarMar::Market.new({id: 39, name: "LaurenEFB", city: "Seattle"})]

  it 'market class should exist' do
    expect(list_of_markets.sample).must_be_instance_of(FarMar::Market)
  end

  it 'self.read_in_csv method should return an array of Market objects' do
    expect(list_of_markets).must_be_instance_of(Array)
    expect(list_of_markets.sample).must_be_instance_of(FarMar::Market)
  end

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
    array_of_names = []
    FarMar::Market.all.each do |market|
      array_of_names << market.name
    end
    expect(array_of_names.include?("People's Co-op Farmers Market")).must_equal(true)
    expect(array_of_names.include?("Medford Farmers Market")).must_equal(true)
    expect(array_of_names.include?("Scripps Ranch Farmers Market & Family Festival")).must_equal(true)
    expect(array_of_names.include?("Warren Farmers Market")).must_equal(true)

  end

end # end of describe
