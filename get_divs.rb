require 'csv'
games_info = {}
CSV.foreach('games_data.csv') do |game_info|
	games_info[game_info[1]] = {
		score: game_info[0].to_i,
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
puts games_info.reverse!
File.open('divs_for_game.html', 'w') do |html|

 end