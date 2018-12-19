require './lib/game_data'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class GameDataTest < MiniTest::Test

  def setup
    @game_path = './data/game_sample.csv'
  end

  def test_it_exists
    game_data = GameData.new(@game_path)

    assert_instance_of GameData, game_data
  end

  def test_data_file_reads_csv

    game_data = GameData.new(@game_path)

    expected_hash = [{"game_id"=>2012030221, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-16", "away_team_id"=>3, "home_team_id"=>6, "away_goals"=>2, "home_goals"=>3, "outcome"=>"home win OT", "home_rink_side_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030222, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-19", "away_team_id"=>3, "home_team_id"=>6, "away_goals"=>2, "home_goals"=>5, "outcome"=>"home win REG", "home_rink_side_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030223, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-21", "away_team_id"=>6, "home_team_id"=>3, "away_goals"=>2, "home_goals"=>1, "outcome"=>"away win REG", "home_rink_side_start"=>"right", "venue"=>"Madison Square Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030224, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-23", "away_team_id"=>6, "home_team_id"=>3, "away_goals"=>3, "home_goals"=>4, "outcome"=>"home win OT", "home_rink_side_start"=>"right", "venue"=>"Madison Square Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030225, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-25", "away_team_id"=>3, "home_team_id"=>6, "away_goals"=>1, "home_goals"=>3, "outcome"=>"home win REG", "home_rink_side_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}]

    assert_equal expected_hash, game_data.data_file
  end
  end
  
