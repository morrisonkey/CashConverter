require 'open-uri'
require 'csv'

namespace :exchange_rates do
  desc "TODO"
  task grab_data: :environment do
    root = "http://sdw.ecb.europa.eu"
    puts
    puts Rainbow("Fetching Conversion Rates From '#{root}'").blue
    puts

    url = "#{root}/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv"

    # because the keyword is stored as a date we can grab the lastest date our data was retrieved by simply calling the last of our Exchanges
    if Exchange.first.nil?
      latest_date = "1999-12-31"
    else
      latest_date = Exchange.all.last._id
    end

    csv_data = open(url)
    csv_rows = CSV.parse(csv_data.read)

    count = 0
    csv_rows.each do |row|
      # check if key is in date format
      if row[0] =~ /^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
        if row[0] == latest_date
          break
        else
          Exchange.create(_id: row[0], rate: row[1])
          count += 1
        end
      end
    end
    if count > 0
      puts "Successfully " + Rainbow("added #{count} days").green + " to the database"
      puts "Added conversion rates from " + Rainbow("#{latest_date} until #{Exchange.all.last._id}").blue
    else
      puts Rainbow("No new dates added").red
      puts "Latest conversion date: " + Rainbow("#{latest_date}").blue
    end
    puts
  end

end
