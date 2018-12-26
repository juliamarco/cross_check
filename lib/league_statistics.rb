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

  def count_of_teams
    @teams_data.count
  end

  def teams_by_goals
    teams = Hash.new(0)
    @games_teams_stats.each do |stat|
      teams[stat.team_id] += stat.goals
    end
    return teams
  end

  def best_offense
    best_offense_id = teams_by_goals.max_by do |team_id, goal|
      goal
    end
    best_offense = @teams_data.find do |team|
      team.team_id == best_offense_id[0]
    end
    return best_offense.teamName
  end


end
