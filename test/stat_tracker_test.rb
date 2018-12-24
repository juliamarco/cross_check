require 'simplecov'
SimpleCov.start

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
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists

    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_holds_the_games_data
skip
    assert_equal 2, @stat_tracker.games_data[0].away_goals
    assert_equal 2012030222, @stat_tracker.games_data[1].game_id
    assert_equal 20122013, @stat_tracker.games_data[2].season
    assert_equal "P", @stat_tracker.games_data[3].type
    assert_equal "2013-05-25", @stat_tracker.games_data[4].date_time
  end

  def test_it_holds_the_teams_data
skip
    assert_equal 1, @stat_tracker.teams_data[0].team_id
    assert_equal 16, @stat_tracker.teams_data[1].franchiseId
    assert_equal "Los Angeles", @stat_tracker.teams_data[2].shortName
    assert_equal "Lightning", @stat_tracker.teams_data[3].teamName
    assert_equal "BOS", @stat_tracker.teams_data[4].abbreviation
  end

  def test_it_has_a_highest_total_score
skip
    assert_equal 9, @stat_tracker.highest_total_score
  end

  def test_it_has_a_lowest_total_score
skip
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_has_a_biggest_blowout
skip
    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_it_has_a_most_popular_venue
skip
    assert_equal "TD Garden", @stat_tracker.most_popular_venue
  end

  def test_it_has_a_least_popular_venue
skip
    assert_equal "CONSOL Energy Center", @stat_tracker.least_popular_venue
  end

  def test_season_with_most_games
skip
    assert_equal "20122013", @stat_tracker.season_with_most_games
  end

  def test_season_with_fewest_games
skip
    assert_equal "20142015", @stat_tracker.season_with_fewest_games
  end

  def test_it_can_show_percentage_of_home_wins
skip
    assert_equal 90, @stat_tracker.percentage_home_wins
  end

  def test_it_can_show_percentage_of_visitor_wins
skip
    assert_equal 10, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_show_count_of_games_by_season
skip
    expected = {20122013=>5, 20132014=>2, 20142015=>1, 20152016=>2}

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_show_average_goals_per_game
skip
    assert_equal 5.6, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
skip
    expected_hash = {20122013 => 2.6, 20132014 => 3.8, 20142015 => 1.0, 20152016 => 3.3}

    assert_equal expected_hash, @stat_tracker.average_goals_by_season
  end

  def test_it_has_a_highest_scoring_visitor

    assert_equal "Wild", @stat_tracker.highest_scoring_visitor
  end

end
