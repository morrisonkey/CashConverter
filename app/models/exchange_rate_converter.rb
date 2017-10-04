class ExchangeRateConverter

  def self.convert(usd, date)
    usd / get_most_recent_exchange(date).rate
  end

  def self.get_most_recent_exchange(date)
    datetime = Date.parse(date)
    until Exchange.find(datetime)
      datetime -= 1.day
    end
    Exchange.find(datetime)
  end

end
