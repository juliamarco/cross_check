require './lib/stat_tracker'
require './lib/game_data'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < MiniTest::Test

  def setup
    @game_path = './data/game_sample.csv'
    @team_path = './data/team_info_sample.csv'
    @game_teams_path = './data/game_teams_stats_sample.csv'
    @locations = {games: @game_path, teams: @team_path, game_teams: @game_teams_path}
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_holds_the_game_data
    stat_tracker = StatTracker.from_csv(@locations)

    expected_hash = {"game_id"=>[2012030221, 2012030222, 2012030223, 2012030224, 2012030225], "season"=>[20122013, 20122013, 20122013, 20122013, 20122013], "type"=>["P", "P", "P", "P", "P"], "date_time"=>["2013-05-16", "2013-05-19", "2013-05-21", "2013-05-23", "2013-05-25"], "away_team_id"=>[3, 3, 6, 6, 3], "home_team_id"=>[6, 6, 3, 3, 6], "away_goals"=>[2, 2, 2, 3, 1], "home_goals"=>[3, 5, 1, 4, 3], "outcome"=>["home win OT", "home win REG", "away win REG", "home win OT", "home win REG"], "home_rink_side_start"=>["left", "left", "right", "right", "left"], "venue"=>["TD Garden", "TD Garden", "Madison Square Garden", "Madison Square Garden", "TD Garden"], "venue_link"=>["/api/v1/venues/null", "/api/v1/venues/null", "/api/v1/venues/null", "/api/v1/venues/null", "/api/v1/venues/null"], "venue_time_zone_id"=>["America/New_York", "America/New_York", "America/New_York", "America/New_York", "America/New_York"], "venue_time_zone_offset"=>[-4, -4, -4, -4, -4], "venue_time_zone_tz"=>["EDT", "EDT", "EDT", "EDT", "EDT"]}

    assert_equal expected_hash, stat_tracker.game_data.data_file
  end

end
