require './lib/stat_tracker'
require './lib/game_data'
require './lib/teams_data'
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

    expected_hash = [{"game_id"=>2012030221, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-16", "away_team_id"=>3, "home_team_id"=>6, "away_goals"=>2, "home_goals"=>3, "outcome"=>"home win OT", "home_rink_side_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030222, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-19", "away_team_id"=>3, "home_team_id"=>6, "away_goals"=>2, "home_goals"=>5, "outcome"=>"home win REG", "home_rink_side_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030223, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-21", "away_team_id"=>6, "home_team_id"=>3, "away_goals"=>2, "home_goals"=>1, "outcome"=>"away win REG", "home_rink_side_start"=>"right", "venue"=>"Madison Square Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030224, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-23", "away_team_id"=>6, "home_team_id"=>3, "away_goals"=>3, "home_goals"=>4, "outcome"=>"home win OT", "home_rink_side_start"=>"right", "venue"=>"Madison Square Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}, {"game_id"=>2012030225, "season"=>20122013, "type"=>"P", "date_time"=>"2013-05-25", "away_team_id"=>3, "home_team_id"=>6, "away_goals"=>1, "home_goals"=>3, "outcome"=>"home win REG", "home_rink_side_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>-4, "venue_time_zone_tz"=>"EDT"}]
    
    assert_equal expected_hash, stat_tracker.game_data.data_file
  end

  def test_it_holds_the_teams_data
    stat_tracker = StatTracker.from_csv(@locations)

    expected_hash = [{"team_id"=>1, "franchiseId"=>23, "shortName"=>"New Jersey", "teamName"=>"Devils", "abbreviation"=>"NJD", "link"=>"/api/v1/teams/1"}, {"team_id"=>4, "franchiseId"=>16, "shortName"=>"Philadelphia", "teamName"=>"Flyers", "abbreviation"=>"PHI", "link"=>"/api/v1/teams/4"}, {"team_id"=>26, "franchiseId"=>14, "shortName"=>"Los Angeles", "teamName"=>"Kings", "abbreviation"=>"LAK", "link"=>"/api/v1/teams/26"}, {"team_id"=>14, "franchiseId"=>31, "shortName"=>"Tampa Bay", "teamName"=>"Lightning", "abbreviation"=>"TBL", "link"=>"/api/v1/teams/14"}, {"team_id"=>6, "franchiseId"=>6, "shortName"=>"Boston", "teamName"=>"Bruins", "abbreviation"=>"BOS", "link"=>"/api/v1/teams/6"}]

    assert_equal expected_hash, stat_tracker.teams_data.data_file
  end



end
