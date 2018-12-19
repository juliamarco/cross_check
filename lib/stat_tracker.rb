require './lib/game_data'


class StatTracker
  attr_reader :game_data
          
  def initialize(locations)
    @game_data = GameData.new(locations[:games])
  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new(locations)
  end

end
