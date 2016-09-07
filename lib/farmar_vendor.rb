require_relative '../farmar.rb'
require 'awesome_print'

class FarMar::Vendor
  attr_reader :id, :name, :num_employees, :market_id

VENDORS = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/vendors.csv')

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @num_employees = hash[:num_employees]
    @market_id = hash[:market_id].to_i
  end

  def self.all
    vendors = []
    VENDORS.each do |line|
      vendor_hash = {}
      vendor_hash[:id] = line[0].to_i
      vendor_hash[:name] = line[1]
      vendor_hash[:num_employees] = line[2].to_i
      vendor_hash[:market_id] = line[3].to_i
      vendors << FarMar::Vendor.new(vendor_hash)
    end
    return vendors
  end


end # end of Vendor
