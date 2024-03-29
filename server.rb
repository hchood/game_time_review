require 'sinatra'
require 'sinatra/reloader'
require 'pry'

#############################
#         DATA
#############################

games = [
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]

#############################
#         METHODS
#############################

def add_to_records(records, team)
  if !records[team]
    records[team] = { wins: 0, losses: 0 }
  end
end

def update_scores(records, game)
  home_team = game[:home_team]
  away_team = game[:away_team]

  if game[:home_score] > game[:away_score]
    # increment home team's wins & away team's losses
    records[home_team][:wins] += 1
    records[away_team][:losses] += 1
  elsif game[:home_score] < game[:away_score]
    # increment home team's losses & away team's wins
    records[home_team][:losses] += 1
    records[away_team][:wins] += 1
  end
end

def team_records(game_data)
  records = {}

  # create a new key value pair for each team in the data
  game_data.each do |game|
    # if home_team isn't already in records hash, create
    # a key-value pair for the team
    home_team = game[:home_team]
    away_team = game[:away_team]

    add_to_records(records, home_team)
    add_to_records(records, away_team)

    # update the number of wins & losses for each team
    update_scores(records, game)
  end

  records
end

def sorted_team_records(game_data)
  team_records = team_records(game_data)
  team_records.sort_by { |team, record| [-record[:wins], record[:losses]] }
end


#############################
#         ROUTES
#############################

get '/leaderboard' do
  @team_records = sorted_team_records(games)

  erb :leaderboard
end









