module LeagueStatistics

  def count_of_teams
    @teams_data.count
  end

  def best_offense
    best_offense_id = goals_scored.max_by do |team_id, goals|
      goals.to_f / count_games_by_team(team_id)
    end
    team_id_name(best_offense_id[0])
  end

  def worst_offense
    worst_offense_id = goals_scored.min_by do |team_id, goals|
      goals.to_f / count_games_by_team(team_id)
    end
    team_id_name(worst_offense_id[0])
  end

  def best_defense
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

  def highest_scoring_visitor
    highest_scoring = average_goals_by_visitor.max_by { |team, goals| goals }
    team_id_name(highest_scoring[0])
  end

  def highest_scoring_home_team
    highest_scoring = average_goals_by_home_team.max_by { |team, goals| goals }
    team_id_name(highest_scoring[0])
  end

  def lowest_scoring_visitor
    highest_scoring = average_goals_by_visitor.min_by { |team, goals| goals }
    team_id_name(highest_scoring[0])
  end

  def lowest_scoring_home_team
    highest_scoring = average_goals_by_home_team.min_by { |team, goals| goals }
    team_id_name(highest_scoring[0])
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
    winningest = percentages.max_by { |team_id, percent| percent }
    team_id_name(winningest[0])
  end

  def best_fans
    team_id = away_and_home_percentages.max_by do |team_id, percent|
      percent[0] - percent[1]
    end[0]
    team_id_name(team_id)
  end

  def worst_fans
    percentages = away_and_home_percentages.find_all do |team_id, percent|
      percent[1] > percent[0]
    end.flatten
    team_id = percentages.find_all { |percent| percent.is_a?(Integer) }
    worst_fans = team_id.map do |team_id|
      @teams_data.find do |team|
        team.team_id == team_id
      end
    end
    worst_fans.map { |team| team.team_name }
  end
end
