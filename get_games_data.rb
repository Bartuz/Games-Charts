require 'nokogiri'
require 'open-uri'
require 'csv'

#Setup number of games to be compared
games = 10000

#Setup nokogoiri to capture page with data
puts "Opening VG-Charts site..."
page = Nokogiri::HTML(open("http://www.vgchartz.com/gamedb/?name=&publisher=&platform=&genre=&minSales=0&results=#{games}"))
puts "Done!"
# =>  				=> data  0	  1       2     3     4		  5      6 7   8  9    10
#contact_row_data = %w( position title platform year genre publisher na eu jp row global )
puts "Creating csv file..."
CSV.open("games_data.csv","wb") do |line|
	page.css('.chart tr').each do |row|
		data = row.css('td')
		next if data[1].nil?
		puts "Getting url for #{data[1].text}..."
		puts search_url = "http://google.com/search?q=" + "#{data[1].text.gsub(" ","+").gsub("/","").gsub("++","+").gsub("é","e").gsub("&","")}+for+#{data[2].text}+rating+score+review"
		puts "Getting score for #{data[1].text}..."
		#Nokogiri::HTML(open(search_url)).css("div.f.slp").text[/..%/] || 
		html_code = Nokogiri::HTML(open(search_url)).css("div.f.slp").text.slice(0,25)
		html_code.join("\n") if html_code.is_a? Array
		puts html_code = html_code.force_encoding("UTF-8")

		score_pattern = html_code[/\d+%/] || html_code[/\d.\d\/10/] || html_code[/\d\d\/10/] || html_code[/\d\/10/] || html_code[/\d.\d/]
		puts score_pattern
		next if score_pattern.nil?
		puts score = if !score_pattern.include?("%")
							if score_pattern.include?("/")
								((score_pattern[/.+\//].to_f)*10).to_i.to_s 
							else
								((score_pattern[/\d.\d/].to_f)*10).to_i.to_s
							end
						else
			 				score_pattern[/..%/].delete("%")
			 			end
		line << [score, data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10]]
		puts "Line added!"
	end
	puts "CSV is done"
end