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

    expected_hash = [{"team_id"=>1, "franchiseId"=>23, "shortName"=>"New Jersey", "teamName"=>"Devils", "abbreviation"=>"NJD", "link"=>"/api/v1/teams/1"}, {"team_id"=>4, "franchiseId"=>16, "shortName"=>"Philadelphia", "teamName"=>"Flyers", "abbreviation"=>"PHI", "link"=>"/api/v1/teams/4"}, {"team_id"=>26, "franchiseId"=>14, "shortName"=>"Los Angeles", "teamName"=>"Kings", "abbreviation"=>"LAK", "link"=>"/api/v1/teams/26"}, {"team_id"=>14, "franchiseId"=>31, "shortName"=>"Tampa Bay", "teamName"=>"Lightning", "abbreviation"=>"TBL", "link"=>"/api/v1/teams/14"}, {"team_id"=>6, "franchiseId"=>6, "shortName"=>"Boston", "teamName"=>"Bruins", "abbreviation"=>"BOS", "link"=>"/api/v1/teams/6"}]

    assert_equal expected_hash, stat_tracker.game_data.data_file
  end

  def test_it_holds_the_game_data
    stat_tracker = StatTracker.from_csv(@locations)

    expected_hash = [{"team_id"=>1, "franchiseId"=>23, "shortName"=>"New Jersey", "teamName"=>"Devils", "abbreviation"=>"NJD", "link"=>"/api/v1/teams/1"}, {"team_id"=>4, "franchiseId"=>16, "shortName"=>"Philadelphia", "teamName"=>"Flyers", "abbreviation"=>"PHI", "link"=>"/api/v1/teams/4"}, {"team_id"=>26, "franchiseId"=>14, "shortName"=>"Los Angeles", "teamName"=>"Kings", "abbreviation"=>"LAK", "link"=>"/api/v1/teams/26"}, {"team_id"=>14, "franchiseId"=>31, "shortName"=>"Tampa Bay", "teamName"=>"Lightning", "abbreviation"=>"TBL", "link"=>"/api/v1/teams/14"}, {"team_id"=>6, "franchiseId"=>6, "shortName"=>"Boston", "teamName"=>"Bruins", "abbreviation"=>"BOS", "link"=>"/api/v1/teams/6"}]

    assert_equal expected_hash, stat_tracker.teams_data.data_file
  end



end
