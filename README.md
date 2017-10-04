# Cash Converter

This app will refresh data for USD to Euro conversion rates dating back to January 1, 2000.



###To install the app:

1. Find repo in github
2. Download or clone repo to your computer
3. In your terminal `$ cd` into the `CashConverter` app folder
4. run command `$ bundle install`



###To update/populate the database: 

1. Fire up mongoDB server
2. In terminal, from within the app folder run the command `$ rake exchange_rates:grab_data`



###To use the app:

1. Enter the rails console in terminal, from within the app folder by running the command `$ rails console`
   1. Searching for a rate:
      * Search for a specific conversion rate with the Exchange.find command and a specific date
        * Example: `> Exchange.find('2011-12-01')`
   2. Converting USD to EURO on a specific date:
      * Find out how much your USD would have been worth on any day in history bye entering the following command with your dollar amount and a date included
        * Example:  `> ExchangeRateConverter.convert(25.25,'2015-01-12')`
      * Get a detailed printout of your conversion by entering the same variables into the following command
        * Example: `>ExhangeRateConverter.get_string_conversion(25.25,'2015-01-12')`





```Copywrite: Keyan Bagheri 2017
All code written by Keyan Bagheri (github.com/keyanbagheri)
```