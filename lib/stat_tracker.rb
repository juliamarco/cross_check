require './lib/games_data'
require './lib/teams_data'
require 'csv'
require './lib/game_statistics'
require './lib/teams_statistics'

class StatTracker
  include GameStatistics
  include TeamStatistics

  attr_reader :games_data,
              :teams_data

  def initialize(games_data, teams_data)
    @games_data = games_data
    @teams_data = teams_data
  end

  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      GameData.new({:game_id => row[0],
                    :season => row[1],
                    :type => row[2],
                    :date_time => row[3],
                    :away_team_id => row[4],
                    :home_team_id => row[5],
                    :away_goals => row[6],
                    :home_goals => row[7],
                    :outcome => row[8],
                    :home_rink_side_start => row[9],
                    :venue => row[10],
                    :venue_link => row[11],
                    :venue_time_zone_id => row[12],
                    :venue_time_zone_offset => row[13],
                    :venue_time_zone_tz => row[14]})
    end
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      TeamsData.new(row)
    end
  StatTracker.new(games_data, teams_data)
  end

end
