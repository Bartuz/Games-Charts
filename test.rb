require 'nokogiri'
require 'open-uri'
require 'csv'

#Setup number of games to be compared
games = 200

#Setup nokogoiri to capture page with data
page = Nokogiri::HTML(open("http://www.vgchartz.com/gamedb/?name=&publisher=&platform=&genre=&minSales=0&results=#{games}"))
# =>          => data  0    1       2     3     4     5      6 7   8  9    10
contact_row_data = %w( position title platform year genre publisher na eu jp row global )

CSV.open("games_data.csv","wb") do |line|
  line << contact_row_data
  page.css('.chart tr').each do |row|
    data = row.css('td')
    puts data[1].text  unless data[1].nil?
    line << [data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10]] unless data[1].nil?
  end
end