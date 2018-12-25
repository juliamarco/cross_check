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
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists

    assert_instance_of TeamsData, @stat_tracker.teams_data[0]
  end

  def test_it_has_attributes

    assert_equal 1, @stat_tracker.teams_data[0].team_id
    assert_equal "Philadelphia", @stat_tracker.teams_data[1].shortName
  end
end
