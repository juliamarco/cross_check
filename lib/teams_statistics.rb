module LeagueStatistics

  def highest_scoring_visitor
    away_team = @games_data.find do |game|
      game.away_goals + game.home_goals == highest_total_score
    end
    away_team_id = away_team.away_team_id
    team = @teams_data.find do |team|
      team.team_id == away_team_id
    end
    team.teamName
  end


end
