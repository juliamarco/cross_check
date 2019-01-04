module SeasonStatisticsHM

  def games_by_season(season)
    season = season.to_i
    games = @games_data.find_all { |game| game.season == season }
    games.map { |game| game.game_id }
  end

  def game_by_type(season, type)
    games = games_by_season(season)
    games = @games_data.map do |game|
      if games.include?(game.game_id)
        if game.type == type
          game.game_id
        end
      end
    end.compact
  end

  def away_goals_scored(games, team_id)
    away_goals_scored = 0
    @games_data.each do |game|
      if games.include?(game.game_id)
        if game.away_team_id == team_id
          away_goals_scored += game.away_goals
        end
      end
    end
    return away_goals_scored
  end

  def away_goals_allowed(games, team_id)
    away_goals_allowed = 0
    @games_data.each do |game|
      if games.include?(game.game_id)
        if game.away_team_id == team_id
          away_goals_allowed += game.home_goals
        end
      end
    end
    return away_goals_allowed
  end

  def home_goals_scored(games, team_id)
    home_goals_scored = 0
    @games_data.each do |game|
      if games.include?(game.game_id)
        if game.home_team_id == team_id
          home_goals_scored += game.home_goals
        end
      end
    end
    return home_goals_scored
  end

  def home_goals_allowed(games, team_id)
    home_goals_allowed = 0
    @games_data.each do |game|
      if games.include?(game.game_id)
        if game.home_team_id == team_id
          home_goals_allowed += game.away_goals
        end
      end
    end
    return home_goals_allowed
  end

  def wins_percentage(season, type)
    games = game_by_type(season, type)
    wins_percentages = Hash.new(0)
    @games_teams_stats.each do |stat|
      if games.include?(stat.game_id)
        if wins_percentages.has_key?(stat.team_id)
          wins_percentages[stat.team_id].push(stat.won)
        else
          wins_percentages[stat.team_id] = [stat.won]
        end
      end
    end
    calculate_percentages(wins_percentages)
  end

  def calculate_percentages(game_outcomes)
    outcomes = game_outcomes.values
    won_outcomes = outcomes.map {|outcome| outcome.count("TRUE")}
    total_outcomes = outcomes.map {|outcome| outcome.count}
    percentages = Hash.new
    game_outcomes.each do |team_id, outcomes|
      if outcomes.include?("TRUE")
        percentages[team_id] = (won_outcomes[0].to_f / total_outcomes[0].to_f)
        won_outcomes.shift
        total_outcomes.shift
      else
        percentages[team_id] = 0.0
        won_outcomes.shift
        total_outcomes.shift
      end
    end
    return percentages
  end

end
