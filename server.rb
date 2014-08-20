require 'sinatra'

require 'csv'

def get_all_players_on_a_team(team_name, data_total)
  players_on_team = []

  data_total.each do |player|
    if player["team"] == team_name
      players_on_team << player
    end
  end
  players_on_team
end

def get_all_players_by_position(position, data_total)
  players_in_each_position = []

  data_total.each do |player|
    if player["position"] == position
      players_in_each_position << player
    end
  end
  players_in_each_position
end

def return_team_array(team_name,data_sep_by_team)

  data_sep_by_team.each do |team_array|
    if team_array.to_s.include?(team_name.to_s)
      return team_array
    end
  end

end

def return_position_array(position, players_in_each_position)
  players_in_each_position.each do |position_array|
    if position_array.to_s.include?(position.to_s)
      return position_array
    end
  end
end

data_total = []

CSV.foreach('lackp_starting_rosters.csv', headers:true) do |row|
  data_total << row
end

teams = []

data_total.each do |row|
  teams << row["team"]
end

teams.uniq!

data_sep_by_team = []

teams.each do |team|
  data_sep_by_team << get_all_players_on_a_team(team, data_total)
end

positions = []

data_total.each do |row|
  positions << row["position"]
end

positions.uniq!

players_in_each_position = []

positions.each do |position|
  players_in_each_position << get_all_players_by_position(position, data_total)
end

teams_hash = {}

teams.each do |team_name|
  teams_hash[team_name] = return_team_array(team_name,data_sep_by_team)
end

positions_hash = {}

positions.each do |position|
  positions_hash[position] = return_position_array(position, players_in_each_position)
end

get '/' do

  html = '''
  <!DOCTYPE>
  <html>
    <head>
      <title>Kickball</title>
    </head>
    <body>
      <h3>The teams are:</h3>
      <ul>
      '''
  teams.each do |team|
    html += "<li>#{team}</li> "
  end

  html += '''
      </ul>
      <h3>The positions are:</h3>
      <ul>
    '''

  positions.each do |position|
    html += "<li>#{position}</li>"
  end

  html += '''
    </body>
  </html>
  '''

end
