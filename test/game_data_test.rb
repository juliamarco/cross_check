require './lib/games_data'
require './lib/stat_tracker'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class GameDataTest < MiniTest::Test

  def setup
    @games_path = './data/game_sample.csv'
    @teams_path = './data/team_info_sample.csv'
    @games_teams_path = './data/game_teams_stats_sample.csv'
    @locations = {games: @games_path, teams: @teams_path, games_teams: @games_teams_path}
  end

  def test_it_exists
    row = 2012030221,20122013,"P","2013-05-16",3,6,2,3,"home win OT","left","TD Garden","/api/v1/venues/null","America/New_York",-4,"EDT"
    games_data = GameData.new(row)

    assert_instance_of GameData, games_data
  end

  def test_data_file_reads_csv
    stat_tracker = StatTracker.from_csv(@locations)

expected_hash = {}
    assert_equal expected_hash, stat_tracker.games_data[0]
  end



end
