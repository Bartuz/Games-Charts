require 'nokogiri'
require 'open-uri'
require 'csv'

#Setup number of games to be compared
games = 200

#Setup nokogoiri to capture page with data
page = Nokogiri::HTML(open("http://www.vgchartz.com/gamedb/?name=&publisher=&platform=&genre=&minSales=0&results=#{games}"))

#Capture data into arrray. Each element is table row.
games = []

contact_row_data = %w( title year platform )

CSV.open("file.csv","wb") do |line|
	line << contact_row_data
	page.css('.chart tr').each do |row|
		data = row.css('td')

		next if data[1].nil?
		
		title = data[1].text
		year = data[3].text
		platform = data[2].text
		
		line << [title,year,platform]
	end
end
# page.css('.chart tr td:nth-child(2) a').each do |t|
	# title << t.text
# end
# print games[0]
# # games.text.strip
# puts games.size
#Create new file 
#File.open("games_data.txt" , "w") do |f|
