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

    expected_hash = [{"team_id"=>1, "franchiseId"=>23, "shortName"=>"New Jersey", "teamName"=>"Devils", "abbreviation"=>"NJD", "link"=>"/api/v1/teams/1"}, {"team_id"=>4, "franchiseId"=>16, "shortName"=>"Philadelphia", "teamName"=>"Flyers", "abbreviation"=>"PHI", "link"=>"/api/v1/teams/4"}, {"team_id"=>26, "franchiseId"=>14, "shortName"=>"Los Angeles", "teamName"=>"Kings", "abbreviation"=>"LAK", "link"=>"/api/v1/teams/26"}, {"team_id"=>14, "franchiseId"=>31, "shortName"=>"Tampa Bay", "teamName"=>"Lightning", "abbreviation"=>"TBL", "link"=>"/api/v1/teams/14"}, {"team_id"=>6, "franchiseId"=>6, "shortName"=>"Boston", "teamName"=>"Bruins", "abbreviation"=>"BOS", "link"=>"/api/v1/teams/6"}]

    assert_equal expected_hash, teams_data.data_file
  end
  end
