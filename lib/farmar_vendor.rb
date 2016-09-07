require_relative '../farmar.rb'
require 'awesome_print'

class FarMar::Vendor

VENDORS = CSV.read('//Users/laurenfries/ada/week-5/farmar/support/vendors.csv')

  def initialize(hash)
    @id = hash[]
  end
end # end of Vendor
