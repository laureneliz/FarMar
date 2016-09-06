require_relative '../farmar.rb'
require 'awesome_print'

class FarMar::Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @address = hash[:address]
    @city = hash[:city]
    @county = hash[:county]
    @state = hash[:state]
    @zip = hash[:zip]
    @@all_markets = []
  end

  def self.read_in_csv(csv_file)
    markets = []
    CSV.open(csv_file).each do |line|
      market_hash = {}
      market_hash[:id] = line[0]
      market_hash[:name] = line[1]
      market_hash[:address] = line[2]
      market_hash[:city] = line[3]
      market_hash[:county] = line[4]
      market_hash[:state] = line[5]
      market_hash[:zip] = line[6]
      markets << FarMar::Market.new(market_hash)
    end
    @@all_markets = markets
  end

  def self.all
    @@all_markets
  end

end
#
# marketlist = FarMar::Market.read_in_csv('//Users/laurenfries/ada/week-5/farmar/support/markets.csv')
#
# ap marketlist
