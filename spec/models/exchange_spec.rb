require 'rails_helper'

RSpec.describe Exchange, type: :model do
  before(:all) do
    @xchange = Exchange.new(_id: '2011-12-25', rate: 1.43)
    @xchange.save
  end

  it 'is an instance of Exchange' do
    expect(@xchange).to be_an_instance_of(Exchange)
  end

  it 'can hold an _id and rate' do
    expect(@xchange._id).to eq('2011-12-25')
    expect(@xchange.rate).to eq(1.43)
  end

  it 'can be saved to the database' do
    expect(Exchange.find('2011-12-25').rate).to eq(1.43)
  end

  after(:all) do
    @xchange.delete
  end
end
