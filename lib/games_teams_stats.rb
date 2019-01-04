class GamesTeamsStats

  attr_reader :game_id,
              :team_id,
              :hoa,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_of_win_percentage,
              :giveaways,
              :takeaways

  def initialize(games_teams_stats)
    @game_id = games_teams_stats[:game_id]
    @team_id = games_teams_stats[:team_id]
    @hoa = games_teams_stats[:hoa]
    @won = games_teams_stats[:won]
    @settled_in = games_teams_stats[:settled_in]
    @head_coach = games_teams_stats[:head_coach]
    @goals = games_teams_stats[:goals]
    @shots = games_teams_stats[:shots]
    @hits = games_teams_stats[:hits]
    @pim = games_teams_stats[:pim]
    @power_play_opportunities = games_teams_stats[:power_play_opportunities]
    @power_play_goals = games_teams_stats[:power_play_goals]
    @face_of_win_percentage = games_teams_stats[:face_of_win_percentage]
    @giveaways = games_teams_stats[:giveaways]
    @takeaways = games_teams_stats[:takeaways]
  end



end
