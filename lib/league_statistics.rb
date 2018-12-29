git module LeagueStatistics

  def count_of_teams
    @teams_data.count
  end

  def teams_by_goals_scored
    teams = Hash.new(0)
    @games_teams_stats.each do |stat|
      teams[stat.team_id] += stat.goals
    end
    return teams
  end

  def best_offense_id
    best_offense_id = teams_by_goals_scored.max_by do |team_id, goal|
    goal
    end
    return best_offense_id[0]
  end

  def worst_offense_id
    worst_offense_id = teams_by_goals_scored.min_by do |team_id, goal|
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

  def teams_by_goals_allowed
    games = Hash.new(0)
    @games_data.each do |game|
      games[game.away_team_id] += game.home_goals
      games[game.home_team_id] += game.away_goals
    end
    return games
  end

  def best_defense_id
    best_defense_id = teams_by_goals_allowed.min_by do |team_id, goals|
      goals
    end
    return best_defense_id[0]
  end

  def worst_defense_id
    worst_defense_id = teams_by_goals_allowed.max_by do |team_id, goals|
      goals
    end
    return worst_defense_id[0]
  end

  def best_defense
    best_defense_team = @teams_data.find do |team|
      team.team_id == best_defense_id
    end
    return best_defense_team.teamName
  end

  def worst_defense
    worst_defense_team = @teams_data.find do |team|
      team.team_id == worst_defense_id
    end
    return worst_defense_team.teamName
  end

  def average_goals_by_visitor
    games = Hash.new(0)
    @games_data.each do |game|
      if games.has_key?(game.away_team_id)
        games[game.away_team_id].push(game.away_goals)
      else
      games[game.away_team_id] = [game.away_goals]
      end
    end
    games.each do |key, value|
      games[key] = value.sum.to_f / value.count.to_f
    end
  end

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

  def highest_scoring_home_team


  end


end
