require 'open-uri'
require 'csv'

namespace :exchange_rates do
  desc "TODO"
  task grab_data: :environment do
    url = "http://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv"

    csv_data = open(url)
    csv_rows = CSV.parse(csv_data.read)

    count = 1
    csv_rows.each do |row|
      if count < 10
        # check if key is in date format
        if row[0] =~ /^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
          puts row[0]
        end
      end
      count += 1
    end
  end

end
