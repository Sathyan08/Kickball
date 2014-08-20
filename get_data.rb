 require 'csv'

 teams = []
 data_total = []


CSV.foreach('lackp_starting_rosters.csv', headers:true) do |row|
  teams << row["team"]
end

CSV.foreach('lackp_starting_rosters.csv', headers:true) do |row|
  data_total << row
end

teams.uniq!

teams.each do |team|
