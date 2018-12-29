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
    @teams_path = './data/team_info.csv'
    @games_teams_path = './data/game_teams_stats_sample.csv'
    @locations = {games: @games_path, teams: @teams_path, games_teams: @games_teams_path}
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists

    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_holds_the_games_data

    assert_equal 2, @stat_tracker.games_data[0].away_goals
    assert_equal 2012030222, @stat_tracker.games_data[1].game_id
    assert_equal 20122013, @stat_tracker.games_data[2].season
    assert_equal "P", @stat_tracker.games_data[3].type
    assert_equal "2013-05-25", @stat_tracker.games_data[4].date_time
  end

  def test_it_holds_the_teams_data

    assert_equal 1, @stat_tracker.teams_data[0].team_id
    assert_equal 16, @stat_tracker.teams_data[1].franchiseId
    assert_equal "Los Angeles", @stat_tracker.teams_data[2].shortName
    assert_equal "Lightning", @stat_tracker.teams_data[3].teamName
    assert_equal "BOS", @stat_tracker.teams_data[4].abbreviation
  end

  def test_it_holds_the_game_teams_stats_data

    assert_equal 2012030221, @stat_tracker.games_teams_stats[0].game_id
    assert_equal 6, @stat_tracker.games_teams_stats[1].team_id
    assert_equal "away", @stat_tracker.games_teams_stats[2].hoA
    assert_equal "TRUE", @stat_tracker.games_teams_stats[3].won
    assert_equal "REG", @stat_tracker.games_teams_stats[4].settled_in
  end

  def test_it_has_a_highest_total_score

    assert_equal 9, @stat_tracker.highest_total_score
  end

  def test_it_has_a_lowest_total_score

    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_has_a_biggest_blowout

    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_it_can_count_venues_occurrences

    expected = {"TD Garden"=>3, "Madison Square Garden"=>2, "United Center"=>2, "Pepsi Center"=>1, "CONSOL Energy Center"=>1, "American Airlines Center"=>1}

    assert_equal expected, @stat_tracker.counts_venues_occurrences
  end

  def test_it_has_a_most_popular_venue

    assert_equal "TD Garden", @stat_tracker.most_popular_venue
  end

  def test_it_has_a_least_popular_venue

    assert_equal "Pepsi Center", @stat_tracker.least_popular_venue
  end

  def test_season_with_most_games

    assert_equal "20122013", @stat_tracker.season_with_most_games
  end

  def test_season_with_fewest_games

    assert_equal "20142015", @stat_tracker.season_with_fewest_games
  end

  def test_it_can_show_percentage_of_home_wins

    assert_equal 90, @stat_tracker.percentage_home_wins
  end

  def test_it_can_show_percentage_of_visitor_wins

    assert_equal 10, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_show_count_of_games_by_season

    expected = {20122013=>5, 20132014=>2, 20142015=>1, 20152016=>2}

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_show_average_goals_per_game

    assert_equal 5.6, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season

    expected_hash = {20122013 => 2.6, 20132014 => 3.8, 20142015 => 1.0, 20152016 => 3.3}

    assert_equal expected_hash, @stat_tracker.average_goals_by_season
  end


  def test_it_can_count_number_of_teams

    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_it_can_arrange_teams_by_goals_scored

    expected_hash = {3=>8, 6=>15, 5=>0, 17=>8, 16=>9, 9=>5, 8=>4}

    assert_equal expected_hash, @stat_tracker.teams_by_goals_scored
  end


  def test_it_has_best_offense_id

    assert_equal 6, @stat_tracker.best_offense_id
  end

  def test_it_has_worst_offense_id

    assert_equal 5, @stat_tracker.worst_offense_id
  end

  def test_it_has_best_offense_name

    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_it_has_worst_offense_name

    assert_equal "Penguins", @stat_tracker.worst_offense
  end

  def test_it_can_arrange_teams_by_goals_allowed

    expected_hash = {3=>22, 6=>10, 19=>5, 16=>1, 30=>9, 21=>4, 14=>2, 5=>3, 25=>0}

    assert_equal expected_hash, @stat_tracker.teams_by_goals_allowed
  end

  def test_it_has_best_defense_id

    assert_equal 25, @stat_tracker.best_defense_id
  end

  def test_it_has_worst_defense_id

    assert_equal 3, @stat_tracker.worst_defense_id
  end

  def test_it_has_best_defense_name

    assert_equal "Stars", @stat_tracker.best_defense
  end

  def test_it_has_worst_defense_name

    assert_equal "Rangers", @stat_tracker.worst_defense
  end

  def test_it_has_average_goals_by_visitor

   expected_hash = {3=>2.0, 6=>2.5, 19=>1.0, 30=>2.0, 14=>0.0}
   assert_equal expected_hash, @stat_tracker.average_goals_by_visitor
  end

  def test_it_has_a_highest_scoring_visitor

    assert_equal "Bruins", @stat_tracker.highest_scoring_visitor
  end

  def test_it_has_average_goals_by_home_team

    expected_hash = {6=>3.6666666666666665, 3=>2.5, 16=>3.5, 21=>5.0, 5=>6.0, 25=>4.0}
    assert_equal expected_hash, @stat_tracker.average_goals_by_home_team
  end

  def test_it_has_highest_scoring_home_team

    assert_equal "Bruins", @stat_tracker.highest_scoring_visitor
  end


end
