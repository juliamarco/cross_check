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

    expected_hash = {"team_id"=>[1, 4, 26, 14, 6], "franchiseId"=>[23, 16, 14, 31, 6], "shortName"=>["New Jersey", "Philadelphia", "Los Angeles", "Tampa Bay", "Boston"], "teamName"=>["Devils", "Flyers", "Kings", "Lightning", "Bruins"], "abbreviation"=>["NJD", "PHI", "LAK", "TBL", "BOS"], "link"=>["/api/v1/teams/1", "/api/v1/teams/4", "/api/v1/teams/26", "/api/v1/teams/14", "/api/v1/teams/6"]}

    assert_equal expected_hash, teams_data.data_file
  end
  end
