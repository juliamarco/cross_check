require './lib/game_data'
require './lib/teams_data'


class StatTracker
  attr_reader :game_data,
              :teams_data

  def initialize(locations)
    @game_data = GameData.new(locations[:games])
    @teams_data = TeamsData.new(locations[:teams])
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new(locations)
  end

end
