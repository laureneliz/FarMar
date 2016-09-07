require_relative '../farmar.rb'
require 'date'

class FarMar::Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

  SALES = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/sales.csv')

  def initialize(hash)
    @id = hash[:id]
    @amount = hash[:amount]
    @purchase_time = hash[:purchase_time]
    @vendor_id = hash[:vendor_id]
    @product_id = hash[:product_id]
  end

  def self.all
    sales = []
    SALES.each do |line|
      sale_hash = {}
      sale_hash[:id] = line[0].to_i
      sale_hash[:amount] = line[1].to_i
      sale_hash[:purchase_time] = line[2]
      sale_hash[:vendor_id] = line[3].to_i
      sale_hash[:product_id] = line[4].to_i
      sales << FarMar::Sale.new(sale_hash)
    end
    return sales
  end

end # end of class
