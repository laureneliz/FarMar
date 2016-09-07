require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'

describe 'testing Vendor class' do

  let(:list_of_vendors) { FarMar::Vendor.all }

  it 'Vendor class should exist' do
    expect(list_of_vendors.sample).must_be_instance_of(FarMar::Vendor)
  end

  # there is no error handling here for in case the data types are nil. use ||= somewhere?
  it 'testing data types for attributes' do
    expect(list_of_vendors.sample.id).must_be_instance_of(Fixnum)
    expect(list_of_vendors.sample.name).must_be_instance_of(String)
    expect(list_of_vendors.sample.num_employees).must_be_instance_of(Fixnum)
    expect(list_of_vendors.sample.market_id).must_be_instance_of(Fixnum)
  end
end # end of describe
