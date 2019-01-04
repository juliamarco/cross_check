require 'simplecov'
SimpleCov.start

require './lib/games_teams_stats'
require 'csv'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class GamesTeamsStatsTest < MiniTest::Test

  def test_it_exists
    games_teams_stats = CSV.read('./data/game_teams_stats_sample.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |row|
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
                    :face_off_win_percentage => row[12],
                    :giveaways => row[13],
                    :takeaways => row[14])
    end

    assert_instance_of GamesTeamsStats, games_teams_stats[0]
  end

  def test_it_has_attributes
    games_teams_stats = CSV.read('./data/game_teams_stats_sample.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |row|
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
                    :face_off_win_percentage => row[12],
                    :giveaways => row[13],
                    :takeaways => row[14])
    end

    assert_equal 2012030221, games_teams_stats[0].game_id
    assert_equal "Claude Julien", games_teams_stats[1].head_coach
  end

end
