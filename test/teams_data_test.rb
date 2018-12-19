require './lib/teams_data'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class TeamsDataTest < MiniTest::Test

  def setup
    @game_path = './data/team_info_sample.csv'
  end

  def test_it_exists
    teams_data = TeamsData.new(@game_path)

    assert_instance_of TeamsData, teams_data
  end

  def test_data_file_reads_csv
    
    teams_data = TeamsData.new(@game_path)

    expected_hash = {"game_id"=>[2012030221, 2012030222, 2012030223, 2012030224, 2012030225], "season"=>[20122013, 20122013, 20122013, 20122013, 20122013], "type"=>["P", "P", "P", "P", "P"], "date_time"=>["2013-05-16", "2013-05-19", "2013-05-21", "2013-05-23", "2013-05-25"], "away_team_id"=>[3, 3, 6, 6, 3], "home_team_id"=>[6, 6, 3, 3, 6], "away_goals"=>[2, 2, 2, 3, 1], "home_goals"=>[3, 5, 1, 4, 3], "outcome"=>["home win OT", "home win REG", "away win REG", "home win OT", "home win REG"], "home_rink_side_start"=>["left", "left", "right", "right", "left"], "venue"=>["TD Garden", "TD Garden", "Madison Square Garden", "Madison Square Garden", "TD Garden"], "venue_link"=>["/api/v1/venues/null", "/api/v1/venues/null", "/api/v1/venues/null", "/api/v1/venues/null", "/api/v1/venues/null"], "venue_time_zone_id"=>["America/New_York", "America/New_York", "America/New_York", "America/New_York", "America/New_York"], "venue_time_zone_offset"=>[-4, -4, -4, -4, -4], "venue_time_zone_tz"=>["EDT", "EDT", "EDT", "EDT", "EDT"]}

    assert_equal expected_hash, teams_data.data_file
  end
  end
