require './lib/games_data'
require './lib/teams_data'
require 'csv'

class StatTracker
  attr_reader :games_data,
              :teams_data

  def initialize(games_data, teams_data)  
    @games_data = games_data
    @teams_data = teams_data
  end

  def self.from_csv(locations)
    games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      GameData.new(row)
    end
    teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      TeamsData.new(row)
    end
  StatTracker.new(games_data, teams_data)
  end

end
