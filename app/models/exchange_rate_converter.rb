class ExchangeRateConverter

  def self.convert(usd, date)
    amount = (usd / get_most_recent_exchange(date).rate).round(4)
    puts
    puts "On #{date} $#{usd} was equal to €#{amount}"
    puts
    amount
  end

  def self.get_most_recent_exchange(date)
    datetime = Date.parse(date)
    until Exchange.find(datetime)
      datetime -= 1.day
    end
    Exchange.find(datetime)
  end

end
