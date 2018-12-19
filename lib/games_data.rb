class GameData

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :outcome,
              :home_rink_side_start,
              :venue,
              :venue_link,
              :venue_time_zone_id,
              :venue_time_zone_offset,
              :venue_time_zone_tz

  def initialize(row)
    @game_id = row[0]
    @season = row[1]
    @type = row[2]
    @date_time = row[3]
    @away_team_id = row[4]
    @home_team_id = row[5]
    @away_goals = row[6]
    @home_goals = row[7]
    @outcome = row[8]
    @home_rink_side_start = row[9]
    @venue = row[10]
    @venue_link = row[11]
    @venue_time_zone_id = row[12]
    @venue_time_zone_offset = row[13]
    @venue_time_zone_tz = row[14]
  end

end
