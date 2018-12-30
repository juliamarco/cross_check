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
    skip
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

  def test_it_holds_the_game_teams_stats_data
    skip
    assert_equal 2012030221, @stat_tracker.games_teams_stats[0].game_id
    assert_equal 6, @stat_tracker.games_teams_stats[1].team_id
    assert_equal "away", @stat_tracker.games_teams_stats[2].hoA
    assert_equal "TRUE", @stat_tracker.games_teams_stats[3].won
    assert_equal "REG", @stat_tracker.games_teams_stats[4].settled_in
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

  def test_it_can_count_venues_occurrences
    skip

    expected = {"TD Garden"=>3, "Madison Square Garden"=>2, "United Center"=>2, "Pepsi Center"=>1, "CONSOL Energy Center"=>1, "American Airlines Center"=>1}

    assert_equal expected, @stat_tracker.counts_venues_occurrences
  end

  def test_it_has_a_most_popular_venue
    skip
    assert_equal "TD Garden", @stat_tracker.most_popular_venue
  end

  def test_it_has_a_least_popular_venue
    skip
    assert_equal "Pepsi Center", @stat_tracker.least_popular_venue
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


  def test_it_can_count_number_of_teams
    skip
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_it_can_arrange_teams_by_goals_scored
skip
    expected_hash = {3=>8, 6=>15, 5=>0, 17=>8, 16=>9, 9=>5, 8=>4}

    assert_equal expected_hash, @stat_tracker.teams_by_goals_scored
  end


  def test_it_has_best_offense
    skip
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_it_has_worst_offense
    skip
    assert_equal "Penguins", @stat_tracker.worst_offense
  end

  def test_it_can_arrange_teams_by_goals_allowed
    skip

    expected_hash = {3=>22, 6=>10, 19=>5, 16=>1, 30=>9, 21=>4, 14=>2, 5=>3, 25=>0}

    assert_equal expected_hash, @stat_tracker.teams_by_goals_allowed
  end

  def test_it_has_best_defense
skip
    assert_equal "Stars", @stat_tracker.best_defense
  end

  def test_it_has_worst_defense
skip
    assert_equal "Rangers", @stat_tracker.worst_defense
  end

  def test_it_has_average_goals_by_visitor
    skip
   expected_hash = {3=>2.0, 6=>2.5, 19=>1.0, 30=>2.0, 14=>0.0}
   assert_equal expected_hash, @stat_tracker.average_goals_by_visitor
  end

  def test_it_has_a_highest_scoring_visitor
    skip

    assert_equal "Bruins", @stat_tracker.highest_scoring_visitor
  end

  def test_it_has_average_goals_by_home_team
    skip

    expected_hash = {6=>3.6666666666666665, 3=>2.5, 16=>3.5, 21=>5.0, 5=>6.0, 25=>4.0}
    assert_equal expected_hash, @stat_tracker.average_goals_by_home_team
  end

  def test_it_has_highest_scoring_home_team
    skip

    assert_equal "Bruins", @stat_tracker.highest_scoring_visitor
  end

  def test_it_has_a_lowest_scoring_visitor
skip
    assert_equal "Lightning", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_has_a_lowest_scoring_home_team
    skip

    assert_equal "Rangers", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_calculate_percentages
    skip
     original_hash = {3=>["FALSE", "TRUE"], 6=>["TRUE", "TRUE", "FALSE"], 5=>["FALSE"], 17=>["FALSE", "FALSE"], 16=>["TRUE", "TRUE"], 9=>["TRUE"], 8=>["FALSE"]}
     expected_hash = {3=>50.0, 6=>66.67, 5=>0.0, 17=>0.0, 16=>100.0, 9=>100.0, 8=>0.0}
     assert_equal expected_hash, @stat_tracker.calculate_percentages(original_hash)
   end

  def test_it_has_a_winningest_team
skip
    assert_equal "Bruins", @stat_tracker.winningest_team
  end

  def test_home_wins_percentages
skip
    expected_hash = {6=>100.0, 16=>66.67, 8=>0.0, 3=>100.0, 5=>0.0, 9=>0.0, 17=>100.0}
    assert_equal expected_hash, @stat_tracker.home_wins_percentages
  end

  def test_away_win_percentages
skip
    expected_hash = {3=>0.0, 5=>0.0, 17=>33.33, 9=>100.0, 6=>50.0, 8=>100.0, 16=>0.0}
    assert_equal expected_hash, @stat_tracker.away_win_percentages
  end

  def test_it_can_merge_away_and_win_percentages
skip
    expected_hash = {6=>[100.0, 50.0], 16=>[66.67, 0.0], 8=>[0.0, 100.0], 3=>[100.0, 0.0], 5=>[0.0, 0.0], 9=>[0.0, 100.0], 17=>[100.0, 33.33]}
    assert_equal expected_hash, @stat_tracker.away_and_home_percentages
  end

  def test_it_has_best_fans
skip
    assert_equal "Rangers", @stat_tracker.best_fans
  end

  def test_it_has_worst_fans
skip
    assert_equal ["Canadiens", "Senators"], @stat_tracker.worst_fans
  end

  def test_it_can_group_games_by_season
skip
    expected_hash = [2013030166, 2013030151, 2013020674, 2013020177, 2013021085, 2013021036]
    assert_equal expected_hash, @stat_tracker.games_by_season(20132014)
  end

  def test_it_can_get_games_by_season_type
skip
    expected = [2013020674, 2013020177, 2013021085, 2013021036]

    preseason = [2013030166, 2013030151]

    assert_equal expected, @stat_tracker.game_by_type(20132014,"R")
  end

  def test_it_has_wins_percentage

    expected = {3=>20.0, 6=>80.0}
    assert_equal expected, @stat_tracker.wins_percentage(20122013, "P")
  end

  def test_it_has_biggest_bust

    assert_equal "Rangers", @stat_tracker.biggest_bust(20122013)
  end

  def test_it_has_a_biggest_surprise

    assert_equal "Bruins", @stat_tracker.biggest_surprise(20122013)
  end

  def test_it_has_a_season_summary

    expected_hash = {:preseason => {:win_percentage => 80.0, :goals_scored => 16, :goals_against => 10} , :regular_season => {:win_percentage => 100.0, :goals_scored => 6, :goals_against => 2}}
    assert_equal expected_hash, @stat_tracker.season_summary(20122013, 6)
  end

  def test_it_has_team_info

    expected_hash = {"team_id" => 1, "franchiseId" => 23, "shortName" => "New Jersey", "teamName" => "Devils", "abbreviation" => "NJD", "link" => "/api/v1/teams/1"}
    assert_equal expected_hash, @stat_tracker.team_info(1)
  end

  def test_it_has_games_won_by_season

    expected = {20122013=>["TRUE"], 20132014=>["TRUE", "FALSE"]}
    assert_equal expected, @stat_tracker.games_won_by_season(24)
  end


  def test_it_has_a_best_season

    assert_equal 20122013, @stat_tracker.best_season(24)
  end

  def test_it_has_a_worst_season

    assert_equal 20132014, @stat_tracker.worst_season(24)
  end

  def test_it_has_an_average_win_percentage

    assert_equal 75.0, @stat_tracker.average_win_percentage(24)
  end

  def test_it_has_most_goals_scored

    assert_equal 3, @stat_tracker.most_goals_scored(24)
  end

  def test_it_has_fewest_goals_scored

    assert_equal 2, @stat_tracker.fewest_goals_scored(24)
  end

  def test_it_has_a_favorite_opponent

    assert_equal "Bruins", @stat_tracker.favorite_opponent(3)
  end

  def test_it_has_a_rival

    assert_equal "Jets", @stat_tracker.rival(3)
  end

  def test_it_has_a_biggest_team_blowout

    assert_equal 4, @stat_tracker.biggest_team_blowout(6)
  end

  def test_it_has_a_worst_loss

    assert_equal 1, @stat_tracker.worst_loss(6)
  end

  def test_it_has_a_head_to_head
    games = [2012030221, 2012030222, 2012030223, 2012030224, 2012030225]
    expected = {win: 4, loss: 1}
    assert_equal expected, @stat_tracker.head_to_head(6, 3)
  end

end
