module TeamStatistics

  def team_info(team_id) #tested line 293
    team = @teams_data.find do |team|
      team.team_id == team_id.to_i
    end
    new = Hash.new(0)
    new["team_id"] = team.team_id.to_s
    new["franchise_id"] = team.franchise_id.to_s
    new["short_name"] = team.short_name
    new["team_name"] = team.team_name
    new["abbreviation"] = team.abbreviation
    new["link"] = team.link
    return new
  end

  def best_season(team_id) #tested line 305
    games_results = games_won_by_season(team_id)
    best_season = calculate_percentages(games_results).max_by do
     |season,outcome| outcome
    end[0]
    best_season.to_s
  end

  def worst_season(team_id) #tested line 310
    games_results = games_won_by_season(team_id)
    best_season = calculate_percentages(games_results).min_by do
     |season,outcome| outcome
    end[0]
    best_season.to_s
  end

  def average_win_percentage(team_id) #tested line 315
    team_id = team_id.to_i
    total_games_played = @games_teams_stats.count {|stat| stat.team_id == team_id}
    total_games_won = @games_teams_stats.count {|stat| stat.team_id == team_id && stat.won == "TRUE"}
    (total_games_won.to_f / total_games_played.to_f).round(2)
  end

  def most_goals_scored(team_id) #tested line 325
    all_team_goals(team_id.to_i).max
  end

  def fewest_goals_scored(team_id) #tested line 330
    all_team_goals(team_id.to_i).min
  end

  def favorite_opponent(team_id) #tested line 353
    hash = Hash.new
    get_opponents_results(team_id.to_i, hash)
    team = calculate_percentages(hash).min_by { |k,v| v }[0]
    team_id_name(team)
  end

  def rival(team_id) #tested line 358
    hash = Hash.new
    get_opponents_results(team_id.to_i, hash)
    team = calculate_percentages(hash).max_by { |k, v| v }[0]
    team_id_name(team)
  end

  def biggest_team_blowout(team_id) #tested line 369
    team_id = team_id.to_i
    games_won = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "TRUE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_won).max
  end

  def worst_loss(team_id) #tested line 374
    team_id = team_id.to_i
    games_lost = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "FALSE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_lost).max
  end

  def head_to_head(team_id) #tested line 379
    team_id = team_id.to_i
    head_to_head = {}
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
