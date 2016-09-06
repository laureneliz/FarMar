require_relative '../farmar.rb'
require 'awesome_print'

class FarMar::Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @address = hash[:address]
    @city = hash[:city]
    @county = hash[:county]
    @state = hash[:state]
    @zip = hash[:zip]
  end

  def self.read_in_csv()
    market_array = []
    CSV.open('../support/markets.csv').each do |line|
      market_hash = {}
      market_hash[:id] = line[0]
      market_hash[:name] = line[1]
      market_hash[:address] = line[2]
      market_hash[:city] = line[3]
      market_hash[:county] = line[4]
      market_hash[:state] = line[5]
      market_hash[:zip] = line[6]
      market_array << FarMar::Market.new(market_hash)
    end
    return market_array
  end

end

marketlist = FarMar::Market.read_in_csv

ap marketlist
