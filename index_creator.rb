require 'csv'
games_info = {}
CSV.foreach('games_data.csv') do |game_info|
	games_info[game_info[1]] = {
		score: game_info[0].to_i,
		name: game_info[1].force_encoding("UTF-8"),
		system: game_info[2],
		year: game_info[3],
		genre: game_info[4],
		publisher: game_info[5],
		na: game_info[6],
		eu: game_info[7],
		jp: game_info[8],
		rest: game_info[9],
		global: game_info[10]
	}
end
games_info = games_info.sort_by {|title,game_info| game_info[:score] }
games_info.reverse!
File.open('WebPage/index.html', 'w') do |html|
	puts "Initializing index. html creation!"
	html.write("<!DOCTYPE HTML>")
	html.write("<html>
		<head>
			<meta charset=\"UTF-8\"/>
			<title>Games-Charts</title>
		</head>
		<body>")
	puts "Creating table head..."

	html.write("\t<table>\n\t\t<caption>Do scores really impact on sales?</caption>\n")
	html.write("\t\t<thead>\n" + "\t\t\t<th>Reviews in %</th>\n" + "\t\t\t<th>Game Title</th>\n" + "\n" + "\t\t</thead>")
 	html.write("\t\t<tbody>\n")
 	games_info.each do |x,g|
	 	puts "Creating new row for #{g[:name]}"
 		html.write("\t\t<tr>\n\t\t\t<td>#{g[:score]}%</td>\n\t\t\t<td>#{g[:name]}</td>\n\t\t<tr>\n")
 	end
 	puts "DONE!"
 	html.write("\t\t</tbody\n")
 	html.write("\t</table>")
 	html.write("</body>")
 	html.write("</html>")
 	puts "Leaving..."
 end