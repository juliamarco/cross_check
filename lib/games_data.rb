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

  def initialize(games_data)
    @game_id = games_data[:game_id]
    @season = games_data[:season]
    @type = games_data[:type]
    @date_time = games_data[:date_time]
    @away_team_id = games_data[:away_team_id]
    @home_team_id = games_data[:home_team_id]
    @away_goals = games_data[:away_goals]
    @home_goals = games_data[:home_goals]
    @outcome = games_data[:outcome]
    @home_rink_side_start = games_data[:home_rink_side_start]
    @venue = games_data[:venue]
    @venue_link = games_data[:venue_link]
    @venue_time_zone_id = games_data[:venue_time_zone_id]
    @venue_time_zone_offset = games_data[:venue_time_zone_offset]
    @venue_time_zone_tz = games_data[:venue_time_zone_tz]

  end

end
