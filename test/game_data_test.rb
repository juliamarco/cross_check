require 'simplecov'
SimpleCov.start

require './lib/games_data'
require 'csv'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class GameDataTest < MiniTest::Test

  def test_it_exists
    games_data = CSV.read('./data/game_sample.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |row|
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

    assert_instance_of GameData, games_data[0]
  end

  def test_it_has_attributes
    games_data = CSV.read('./data/game_sample.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |row|
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

    assert_equal 2012030221, games_data[0].game_id
    assert_equal 20122013, games_data[1].season
  end

end
