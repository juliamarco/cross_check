require './lib/stat_tracker'
require './lib/games_data'
require './lib/teams_data'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < MiniTest::Test

  def setup
    @games_path = './data/game_sample.csv'
    @teams_path = './data/team_info_sample.csv'
    @games_teams_path = './data/game_teams_stats_sample.csv'
    @locations = {games: @games_path, teams: @teams_path, games_teams: @games_teams_path}
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_holds_the_game_data
    stat_tracker = StatTracker.from_csv(@locations)

    assert_equal 2, stat_tracker.games_data[0].away_goals
    assert_equal 2012030222, stat_tracker.games_data[1].game_id
    assert_equal 20122013, stat_tracker.games_data[2].season
    assert_equal "P", stat_tracker.games_data[3].type
    assert_equal "2013-05-25", stat_tracker.games_data[4].date_time

  end

  def test_it_holds_the_teams_data
    stat_tracker = StatTracker.from_csv(@locations)

    assert_equal 1, stat_tracker.teams_data[0].team_id
    assert_equal 16, stat_tracker.teams_data[1].franchiseId
    assert_equal "Los Angeles", stat_tracker.teams_data[2].shortName
    assert_equal "Lightning", stat_tracker.teams_data[3].teamName
    assert_equal "BOS", stat_tracker.teams_data[4].abbreviation
  end


end
