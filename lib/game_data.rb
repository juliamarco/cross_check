require 'csv'

class GameData
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

  def merge_hashes
    @data_file.inject do |total, new|
      #first iteration total is data_file[0] and new is data_file[1]
      #second iteration total is [data_file[0], data_file[1] and new is data_file[2]
      #etc.
      total.merge!(new) do |key, oldval, newval|
        [newval, oldval]
        #its creating a merged array of values with same keys
      end
    end
    new_hash = {}
    @data_file[0].each do |keys, values|
      if new_hash.has_key?(keys)
          new_hash[keys].push(values.flatten.reverse)
      else
          new_hash[keys] = values.flatten.reverse
      end
    end
    @data_file = new_hash
    return @data_file
  end

end
