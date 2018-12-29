class GamesTeamsStats

  attr_reader :game_id,
              :team_id,
              :hoA,
              :won,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :pim,
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(games_teams_stats)
    @game_id = games_teams_stats[:game_id]
    @team_id = games_teams_stats[:team_id]
    @hoA = games_teams_stats[:HoA]
    @won = games_teams_stats[:won]
    @settled_in = games_teams_stats[:settled_in]
    @head_coach = games_teams_stats[:head_coach]
    @goals = games_teams_stats[:goals]
    @shots = games_teams_stats[:shots]
    @hits = games_teams_stats[:hits]
    @pim = games_teams_stats[:pim]
    @powerPlayOpportunities = games_teams_stats[:powerPlayOpportunities]
    @powerPlayGoals = games_teams_stats[:powerPlayGoals]
    @faceOffWinPercentage = games_teams_stats[:faceOffWinPercentage]
    @giveaways = games_teams_stats[:giveaways]
    @takeaways = games_teams_stats[:takeaways]
  end



end
