require 'csv'
require './lib/merge_hashes_module'


class GameData
  include MergeHashes

  attr_reader :data_file

  def initialize(path)
    @data_file = []
    read(path)
    merge_hashes
  end

  def read(path)
    keys = ["game_id",
      "season",
      "type",
      "date_time",
      "away_team_id",
      "home_team_id",
      "away_goals",
      "home_goals",
      "outcome",
      "home_rink_side_start",
      "venue",
      "venue_link",
      "venue_time_zone_id",
      "venue_time_zone_offset",
      "venue_time_zone_tz"]

    @data_file = CSV.read(path, converters: :numeric).map do |row|
      Hash[keys.zip(row)]
    end
    @data_file.shift
    return @data_file
  end



end
