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

# In this scenario, everytime we call stattracker.gamedata, it'll reload the files.
# Might get slow eventually if we're doing this.
# We may want to not call locations in initialize, move to different method?
