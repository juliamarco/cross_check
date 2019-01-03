module LeagueStatistics

  def count_of_teams #tested line 121
    @teams_data.count
  end

  def count_games_by_team(team_id)
    @games_teams_stats.count do |stat|
      stat.team_id == team_id
    end
  end

 # Helper Method
  def goals_scored #tested line 126
    games = Hash.new(0)
    @games_data.each do |game|
      games[game.away_team_id] += game.away_goals
      games[game.home_team_id] += game.home_goals
    end
    return games
  end

  def best_offense #tested line 137
    best_offense_id = goals_scored.max_by do |team_id, goals|
      goals.to_f / count_games_by_team(team_id)
    end
    team_id_name(best_offense_id[0])
  end

  def worst_offense #tested line 142
    worst_offense_id = goals_scored.min_by do |team_id, goals|
      goals.to_f / count_games_by_team(team_id)
    end
    team_id_name(worst_offense_id[0])
  end

  def goals_allowed #tested line 147
    games = Hash.new(0)
    @games_data.each do |game|
      games[game.away_team_id] += game.home_goals
      games[game.home_team_id] += game.away_goals
    end
    return games
  end

  def best_defense #tested line 153
    best_defense_id = goals_allowed.min_by do |team_id, goals|
      goals.to_f / count_games_by_team(team_id)
    end
    team_id_name(best_defense_id[0])
  end

  def worst_defense
    worst_defense_id = goals_allowed.max_by do |team_id, goals|
      goals.to_f / count_games_by_team(team_id)
    end
    team_id_name(worst_defense_id[0])
  end


# Helper Method
  def get_averages(hash)
    hash.each do |key, value|
      hash[key] = (value.sum.to_f / value.count.to_f).round(1)
    end
    return hash
  end

# Helper Method
  def average_goals_by_visitor #tested line 163
    games = Hash.new(0)
    @games_data.each do |game|
      if games.has_key?(game.away_team_id)
        games[game.away_team_id].push(game.away_goals)
      else
      games[game.away_team_id] = [game.away_goals]
      end
    end
    get_averages(games)
  end

  def highest_scoring_visitor #tested line 169
    highest_scoring = average_goals_by_visitor.max_by { |k,v| v }
    team_id_name(highest_scoring[0])
  end

# Helper Method
  def average_goals_by_home_team #tested line 174
    games = Hash.new(0)
    @games_data.each do |game|
      if games.has_key?(game.home_team_id)
        games[game.home_team_id].push(game.home_goals)
      else
      games[game.home_team_id] = [game.home_goals]
      end
    end
    get_averages(games)
  end

  def highest_scoring_home_team #tested line 180
    highest_scoring = average_goals_by_home_team.max_by { |k,v| v }
    team_id_name(highest_scoring[0])
  end

  def lowest_scoring_visitor #tested line 185
    highest_scoring = average_goals_by_visitor.min_by { |k,v| v }
    team_id_name(highest_scoring[0])
  end

  def lowest_scoring_home_team #tested line 190
    highest_scoring = average_goals_by_home_team.min_by { |k,v| v }
    team_id_name(highest_scoring[0])
  end

  def winningest_team #tested line 202
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

# Helper Method
  def home_wins_percentages #tested line 207
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

# Helper Method
  def away_win_percentages #tested line 213
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

  def away_and_home_percentages #tested line 219
    both = home_wins_percentages.merge(away_win_percentages) do |key, oldval, newval|
      [oldval, newval]
    end
  end

  def best_fans #tested line 225
    team_id = away_and_home_percentages.max_by do |key, value|
      value[0] - value[1]
    end[0]
    team_id_name(team_id)
  end

  def worst_fans #tested line 230
    worst = away_and_home_percentages.find_all do |key, value|
      value[1] > value[0]
    end.flatten
    if worst.empty?
      return "There are no worst fans!"
    end
    team_id = worst.find_all { |num| num.is_a?(Integer) }
    final_array = team_id.map do |id|
      @teams_data.find do |team|
        team.team_id == id
      end
    end
    final_array.map { |team| team.teamName }
  end
end
