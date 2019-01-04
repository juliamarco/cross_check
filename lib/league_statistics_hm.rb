module LeagueStatisticsHM

  def count_games_by_team(team_id)
    @games_teams_stats.count do |stat|
      stat.team_id == team_id
    end
  end

  def goals_scored
    games = Hash.new(0)
    @games_data.each do |game|
      games[game.away_team_id] += game.away_goals
      games[game.home_team_id] += game.home_goals
    end
    return games
  end

  def goals_allowed
    games = Hash.new(0)
    @games_data.each do |game|
      games[game.away_team_id] += game.home_goals
      games[game.home_team_id] += game.away_goals
    end
    return games
  end

  def get_averages(games)
    games.each do |team_id, goals|
      games[team_id] = (goals.sum.to_f / goals.count.to_f)
    end
    return games
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
    get_averages(games)
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
    get_averages(games)
  end

  def home_wins_percentages
    home_team_wins = Hash.new(0)
    @games_teams_stats.each do |stat|
      if stat.hoa == "home"
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
      if stat.hoa == "away"
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
    home_wins_percentages.merge(away_win_percentages) do |team_id, h_win_percent, a_win_percent|
      [h_win_percent, a_win_percent]
    end
  end

end
