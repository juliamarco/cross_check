require 'simplecov'
SimpleCov.start

require './lib/teams_data'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class TeamsDataTest < MiniTest::Test

  def setup
    @games_path = './data/game_sample.csv'
    @teams_path = './data/team_info_sample.csv'
    @games_teams_path = './data/game_teams_stats_sample.csv'
    @locations = {games: @games_path, teams: @teams_path, games_teams: @games_teams_path}
  end

  def test_it_exists
    expected = 1,23,"New Jersey","Devils","NJD","/api/v1/teams/1"
    teams_data = TeamsData.new(expected)

    assert_instance_of TeamsData, teams_data
  end

  def test_it_has_attributes
    expected = 1,23,"New Jersey","Devils","NJD","/api/v1/teams/1"
    teams_data = TeamsData.new(expected)

    assert_equal 1, teams_data.team_id
    assert_equal 23, teams_data.franchiseId
    assert_equal "New Jersey", teams_data.shortName
  end
end
