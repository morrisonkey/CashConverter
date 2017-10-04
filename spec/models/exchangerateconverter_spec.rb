require 'rails_helper'
require 'rake'

RSpec.describe ExchangeRateConverter, type: :model do
  before do
    Exchange.find('2016-12-27').delete
    Exchange.find('2016-12-23').delete
    Exchange.find('2016-12-22').delete
    Exchange.find('2016-12-21').delete
    Exchange.create(_id: '2016-12-27', rate: 1.0445)
    Exchange.create(_id: '2016-12-23', rate: 1.0446)
    Exchange.create(_id: '2016-12-22', rate: 1.0444)
    Exchange.create(_id: '2016-12-21', rate: 1.0421)
  end

  describe '#get_most_recent_exchange' do
    it "returns the most recent valid exchange rate by date" do
      expect(ExchangeRateConverter.get_most_recent_exchange(Date.parse('2016-12-26'), 0)).to eq(Exchange.find('2016-12-23'))
    end

    it "timeout: returns nil if it goes back 7 days without finding a valid date" do
      expect(ExchangeRateConverter.get_most_recent_exchange(Date.parse('2017-1-26'), 0)).to eq(nil)
    end
  end

  describe '#convert(usd,date)' do

    it 'correctly converts usd to euro' do
      expect(ExchangeRateConverter.convert(120,'2016-12-22')).to eq(114.8985)
      expect(ExchangeRateConverter.convert(120,'2016-12-27')).to eq(114.8875)
      expect(ExchangeRateConverter.convert(90,'2016-12-21')).to eq(86.3641)
    end

    it "converts to the most recent date if chosen date doesn't exist" do
        expect(ExchangeRateConverter.convert(120,'2016-12-26')).to eq(ExchangeRateConverter.convert(120,'2016-12-23'))
    end

    it 'returns nil if outside of date range' do
        expect(ExchangeRateConverter.convert(120,'1990-12-26')).to eq(nil)
        expect(ExchangeRateConverter.convert(120,'2999-12-26')).to eq(nil)
    end

  end

  describe '#get_string_conversion(usd,date)' do
    it 'returns a string detail of conversion' do
      expect(ExchangeRateConverter.get_string_conversion(120,'2016-12-22')).to eq("On 2016-12-22 $120 was equal to €114.8985")
    end
  end

end
