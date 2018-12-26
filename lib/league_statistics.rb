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

  def best_offense_id
    best_offense_id = teams_by_goals.max_by do |team_id, goal|
    goal
    end
    return best_offense_id[0]
  end

  def worst_offense_id
    worst_offense_id = teams_by_goals.min_by do |team_id, goal|
    goal
    end
    return worst_offense_id[0]
  end

  def best_offense
    best_offense = @teams_data.find do |team|
      team.team_id == best_offense_id
    end
    return best_offense.teamName
  end

  def worst_offense
    worst_offense = @teams_data.find do |team|
      team.team_id == worst_offense_id
    end
    return worst_offense.teamName
  end

  def best_defense
    teams_by_goals
    worst_offense_id
    # binding.pry
  end

end
