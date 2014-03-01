require 'sinatra'
require 'shotgun'
require 'pry'


def results
    [
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
end


def unsorted_standings
  standings = {}
  results.each do |game|
    standings[game[:home_team].to_sym] = [{wins: 0}, {losses: 0}, {ties: 0}]
    standings[game[:away_team].to_sym] = [{wins: 0}, {losses: 0}, {ties: 0}]
  end

  results.each do |game|
    if game[:home_score] > game[:away_score]
      standings[game[:home_team].to_sym][0][:wins] += 1
      standings[game[:away_team].to_sym][1][:losses] += 1
    elsif game[:away_score] > game[:home_score]
      standings[game[:home_team].to_sym][1][:losses] += 1
      standings[game[:away_team].to_sym][0][:wins] += 1
    else
      standings[game[:home_team].to_sym][2][:ties] += 1
      standings[game[:away_team].to_sym][2][:ties] += 1
    end
  end
  standings
end

def standings_array
  sorted_standings = []
  unsorted_standings.each do |team, results|
    sorted_standings << {team: team, wins: results[0][:wins], losses: results[1][:losses], ties: results[2][:ties]}
  end
  sorted_standings
end

def sorted_standings
  standings_array.sort_by! { |hash| [-hash[:wins], hash[:losses]] }
end

before do
  @standings = sorted_standings
end

get '/' do
  erb :index
end

get "/leaderboard" do
  erb :leaderboard
end









