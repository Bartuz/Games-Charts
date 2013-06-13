File.open('divs_for_game.html', 'w') do |html|
	games_array = []
	File.readlines('games_data.csv').each do |csv_file_row|
		while( games_data_row  = csv_file_row )
			
			html.write(games_data_row.split(",").join(" ") + "\n")
		end
		# games_array.each {|x|	html.write(x)}
	end
end