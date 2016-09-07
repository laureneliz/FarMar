require_relative '../farmar.rb'

class FarMar::Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

  PRODUCTS = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/sales.csv')

  def initialize(hash)
    @id = hash[:id]
    @amount = hash[:amount]
    @purchase_time = hash[:purchase_time]
    @vendor_id = hash[:vendor_id]
    @product_id = hash[:product_id]
  end



end # end of class
