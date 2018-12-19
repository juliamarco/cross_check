require 'csv'
require './lib/game_data'
require './lib/merge_hashes_module'


class TeamsData
  include MergeHashes

  attr_reader :data_file

  def initialize(path)
    @data_file = []
    read(path)
  end

  def read(path)
    keys = ["team_id",
      "franchiseId",
      "shortName",
      "teamName",
      "abbreviation",
      "link"]

    @data_file = CSV.read(path, converters: :numeric).map do |row|
      Hash[keys.zip(row)]
    end
    @data_file.shift
    return @data_file
  end



end
