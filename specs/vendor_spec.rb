require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'

describe 'testing Vendor class' do

  let(:list_of_vendors) { FarMar::Vendor.all }
  let(:random_vendor) { FarMar::Vendor.all.sample }

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

  it 'self.all should return an array of all vendors' do
    expect(list_of_vendors).must_be_instance_of(Array)
    expect(list_of_vendors.length).must_equal(2690)
  end

  it 'it self.all array should contain all vendors, including a random sampling of vendor names' do
    # i can't figure out how to do this with a let. :(
    array_of_names = []
    list_of_vendors.each do |vendor|
      array_of_names << vendor.name
    end
    expect(array_of_names.include?("Lockman, Gleason and Hettinger")).must_equal(true)
    expect(array_of_names.include?("Tremblay, Casper and Heidenreich")).must_equal(true)
    expect(array_of_names.include?("Leffler Group")).must_equal(true)
    expect(array_of_names.include?("Muller, Hansen and Lakin")).must_equal(true)
  end

  it 'self.all should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_vendors.sample.all} ).must_raise(NoMethodError)
  end

  it 'self.find(id) must return a Vendor' do
    expect(FarMar::Vendor.find(random_vendor.id)).must_be_instance_of(FarMar::Vendor)
  end

  it 'self.find(id) should be a class method, and thus raise method error if called on an instance' do
    expect( proc {list_of_vendors.sample.find(random_vendor.id)} ).must_raise(NoMethodError)
  end

end # end of describe
