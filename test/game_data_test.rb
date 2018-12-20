require 'simplecov'
SimpleCov.start

require './lib/games_data'
require './lib/stat_tracker'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class GameDataTest < MiniTest::Test

  # stattracker is a loader, whereas a test could potentially have instances of games & attributes... move this stuff to stattracker?
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

  def test_it_has_attributes
    row = 2012030221,20122013,"P","2013-05-16",3,6,2,3,"home win OT","left","TD Garden","/api/v1/venues/null","America/New_York",-4,"EDT"
    games_data = GameData.new(row)

    assert_equal 2012030221, games_data.game_id
  end

end
