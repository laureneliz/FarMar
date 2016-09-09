require_relative '../farmar.rb'
require_relative './farmar_vendor'

class FarMar::Market < FarMar::Shared
  attr_reader :id, :name, :address, :city, :county, :state, :zip

  MARKETS = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/markets.csv')

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @address = hash[:address]
    @city = hash[:city]
    @county = hash[:county]
    @state = hash[:state]
    @zip = hash[:zip]

  end

  def self.all
    markets = []
    MARKETS.each do |line|
      market_hash = {}
      market_hash[:id] = line[0].to_i
      market_hash[:name] = line[1]
      market_hash[:address] = line[2]
      market_hash[:city] = line[3]
      market_hash[:county] = line[4]
      market_hash[:state] = line[5]
      market_hash[:zip] = line[6]
      markets << FarMar::Market.new(market_hash)
    end
    return markets
  end

  def self.find(id)
    super
    # id.class != Fixnum ? raise(ArgumentError) : id
    #
    # self.all.each do |market|
    #   if market.id == id
    #     return market
    #   end
    # end
  end

  def vendors
    vendors = []
    all_vendors = FarMar::Vendor.all
    all_vendors.each do |vendor|
      if vendor.market_id == self.id
        vendors << vendor
      end
    end
    return vendors
  end

end
#
# a = FarMar::Market.all
# ap a
