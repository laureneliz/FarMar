require_relative 'spec_helper'
require_relative '../lib/farmar_market'


describe 'testing market class' do

  it 'market class should exist' do
    expect(FarMar::Market.new).must_be_instance_of(FarMar::Market)
  end

  it 'read_in_csv method should return an array of Market objects' do
    list_of_markets = FarMar::Market.read_in_csv
    expect(list_of_markets).must_be_instance_of(Array)
    expect(list_of_markets.sample).must_be_instance_of(FarMar::Market)
  end

  it 'testing data types for attributes' do
    market = FarMar::Market.new
    expect(market.id).must_be_instance_of(Fixnum)
    expect(market.name).must_be_instance_of(String)
    expect(market.address).must_be_instance_of(String)
    expect(market.city).must_be_instance_of(String)
    expect(market.county).must_be_instance_of(String)
    expect(market.state).must_be_instance_of(String)
    expect(market.zip).must_be_instance_of(String)
  end


end # end of describe
