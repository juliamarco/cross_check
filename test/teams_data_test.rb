require 'simplecov'
SimpleCov.start

require './lib/teams_data'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'

class TeamsDataTest < MiniTest::Test

  def test_it_exists
    teams_data = CSV.read('./data/team_info_sample.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      TeamsData.new(:team_id => row[0],
                     :franchiseId => row[1],
                     :shortName => row[2],
                     :teamName => row[3],
                     :abbreviation => row[4],
                     :link => row[5])
    end

    assert_instance_of TeamsData, teams_data[0]
  end

  def test_it_has_attributes
    teams_data = CSV.read('./data/team_info_sample.csv', headers: true, header_converters: :symbol, converters: :numeric).map do |row|
      TeamsData.new(:team_id => row[0],
                     :franchiseId => row[1],
                     :shortName => row[2],
                     :teamName => row[3],
                     :abbreviation => row[4],
                     :link => row[5])
    end

    assert_equal 1, teams_data[0].team_id
    assert_equal "Philadelphia", teams_data[1].shortName
  end

end
