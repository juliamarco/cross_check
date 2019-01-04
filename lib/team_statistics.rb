module TeamStatistics

  def team_info(team_id)
    team = @teams_data.find do |team|
      team.team_id == team_id.to_i
    end
    team_info = Hash.new(0)
    team_info["team_id"] = team.team_id.to_s
    team_info["franchise_id"] = team.franchise_id.to_s
    team_info["short_name"] = team.short_name
    team_info["team_name"] = team.team_name
    team_info["abbreviation"] = team.abbreviation
    team_info["link"] = team.link
    return team_info
  end

  def best_season(team_id)
    games_results = games_won_by_season(team_id)
    best_season = calculate_percentages(games_results).max_by do
     |season, outcome| outcome
    end[0]
    best_season.to_s
  end

  def worst_season(team_id)
    games_results = games_won_by_season(team_id)
    best_season = calculate_percentages(games_results).min_by do
     |season, outcome| outcome
    end[0]
    best_season.to_s
  end

  def average_win_percentage(team_id)
    team_id = team_id.to_i
    total_games_played = @games_teams_stats.count { |stat| stat.team_id == team_id }
    total_games_won = @games_teams_stats.count { |stat| stat.team_id == team_id && stat.won == "TRUE" }
    (total_games_won.to_f / total_games_played.to_f).round(2)
  end

  def most_goals_scored(team_id)
    all_team_goals(team_id.to_i).max
  end

  def fewest_goals_scored(team_id)
    all_team_goals(team_id.to_i).min
  end

  def favorite_opponent(team_id)
    favorite_opponent = Hash.new
    get_opponents_results(team_id.to_i, favorite_opponent)
    team_id = calculate_percentages(favorite_opponent).min_by { |team_id, outcomes| outcomes }[0]
    team_id_name(team_id)
  end

  def rival(team_id)
    rival = Hash.new
    get_opponents_results(team_id.to_i, rival)
    team_id = calculate_percentages(rival).max_by { |team_id, outcomes| outcomes }[0]
    team_id_name(team_id)
  end

  def biggest_team_blowout(team_id)
    team_id = team_id.to_i
    games_won = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "TRUE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_won).max
  end

  def worst_loss(team_id)
    team_id = team_id.to_i
    games_lost = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "FALSE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_lost).max
  end

  def head_to_head(team_id)
    team_id = team_id.to_i
    head_to_head = Hash.new
    opponents = all_opponents(team_id)
    opponents.each do |opponent|
      games_played = games_played_against(team_id, opponent)
      games_won = games_won_against(team_id, opponent)
      percentage = (games_won.to_f / games_played.to_f).round(2)
      head_to_head[team_id_name(opponent)] = percentage
    end
    return head_to_head
  end

end
