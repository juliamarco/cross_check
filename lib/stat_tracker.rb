require 'csv'
require 'pry'
require_relative './games_data'
require_relative './teams_data'
require_relative './games_teams_stats'
require_relative './game_statistics'
require_relative './league_statistics'
require_relative './league_statistics_hm'
require_relative './season_statistics'
require_relative './season_statistics_hm'
require_relative './team_statistics'
require_relative './team_statistics_hm'
require_relative './seasonal_summary'

class StatTracker
  include GameStatistics
  include LeagueStatistics
  include LeagueStatisticsHM
  include SeasonStatistics
  include SeasonStatisticsHM
  include TeamStatistics
  include TeamStatisticsHM
  include SeasonalSummary

  attr_reader :games_data,
              :teams_data,
              :games_teams_stats

  def initialize(games_data, teams_data, games_teams_stats)
    @games_data = games_data
    @teams_data = teams_data
    @games_teams_stats = games_teams_stats
  end

  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      GameData.new(:game_id => row[0],
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
                    :venue_time_zone_tz => row[14])
    end
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      TeamsData.new(:team_id => row[0],
                     :franchise_id => row[1],
                     :short_name => row[2],
                     :team_name => row[3],
                     :abbreviation => row[4],
                     :link => row[5])
    end
    games_teams_stats = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      GamesTeamsStats.new(:game_id => row[0],
                    :team_id => row[1],
                    :hoa => row[2],
                    :won => row[3],
                    :settled_in => row[4],
                    :head_coach => row[5],
                    :goals => row[6],
                    :shots => row[7],
                    :hits => row[8],
                    :pim => row[9],
                    :power_play_opportunities => row[10],
                    :power_play_goals => row[11],
                    :face_of_win_percentage => row[12],
                    :giveaways => row[13],
                    :takeaways => row[14])
  end
  StatTracker.new(games_data, teams_data, games_teams_stats)
  end

end
