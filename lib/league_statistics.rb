module LeagueStatistics

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
  
  def team_id_name(id)
    team = @teams_data.find do |team|
      team.team_id == id
    end
    return team.teamName
  end

  def best_offense
    team_id_name(best_offense_id)
  end

  def worst_offense
    team_id_name(worst_offense_id)
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
    team_id_name(best_defense_id)
  end

  def worst_defense
    team_id_name(worst_defense_id)
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
  
  def average_goals_by_home_team
    games = Hash.new(0)
    @games_data.each do |game|
      if games.has_key?(game.home_team_id)
        games[game.home_team_id].push(game.home_goals)
      else
      games[game.home_team_id] = [game.home_goals]
      end
    end
    games.each do |key, value|
      games[key] = value.sum.to_f / value.count.to_f
    end
  end

  def highest_scoring_visitor
    highest_scoring = average_goals_by_visitor.max_by do |k,v|
      v
    end
    team_id_name(highest_scoring[0])
  end

  def highest_scoring_home_team
    highest_scoring = average_goals_by_home_team.max_by do |k,v|
      v
    end
    team_id_name(highest_scoring[0])
  end

  def lowest_scoring_visitor
    highest_scoring = average_goals_by_visitor.min_by do |k,v|
      v
    end
    team_id_name(highest_scoring[0])
  end

  def lowest_scoring_home_team
    highest_scoring = average_goals_by_home_team.min_by do |k,v|
      v
    end
    team_id_name(highest_scoring[0])
  end

  def calculate_percentages(hash)
    values = hash.values
    won_outcomes = values.map {|value| value.count("TRUE")}
    total_outcomes = values.map {|value| value.count}
    percentages = Hash.new
    hash.each do |key, value|
      percentages[key] = (won_outcomes[0].to_f / total_outcomes[0].to_f * 100).round(2)
      won_outcomes.shift
      total_outcomes.shift
    end
    return percentages
  end

  def winningest_team
    team_wins = Hash.new(0)
    @games_teams_stats.each do |stat|
      if team_wins.has_key?(stat.team_id)
        team_wins[stat.team_id].push(stat.won)
      else
        team_wins[stat.team_id] = [stat.won]
      end
    end
    percentages = calculate_percentages(team_wins)
    winningest = percentages.max_by {|k,v| v}
    team_id_name(winningest[0])
  end

  def home_wins_percentages
    home_team_wins = Hash.new(0)
    @games_teams_stats.each do |stat|
      if stat.hoA == "home"
        if home_team_wins.has_key?(stat.team_id)
          home_team_wins[stat.team_id].push(stat.won)
        else
          home_team_wins[stat.team_id] = [stat.won]
        end
      end
    end
    calculate_percentages(home_team_wins)
  end

  def away_win_percentages
    away_team_wins = Hash.new(0)
    @games_teams_stats.each do |stat|
      if stat.hoA == "away"
        if away_team_wins.has_key?(stat.team_id)
          away_team_wins[stat.team_id].push(stat.won)
        else
          away_team_wins[stat.team_id] = [stat.won]
        end
      end
    end
    calculate_percentages(away_team_wins)
  end

  def away_and_home_percentages
    with_both_values = home_wins_percentages.merge(away_win_percentages) do |key, oldval, newval|
      [oldval, newval]
    end
  end

  def best_fans
    team_id = away_and_home_percentages.max_by do |key, value|
      value[0] - value[1]
    end[0]
    team_id_name(team_id)
  end

  def worst_fans
    worst = away_and_home_percentages.find_all do |key, value|
      value[1] > value[0]
    end.flatten
    team_id = worst.find_all {|num| num.is_a?(Integer)}
    final_array = team_id.map do |id|
      @teams_data.find do |team|
        team.team_id == id
      end
    end
    final_array.map do |team|
      team.teamName
    end
  end


end
