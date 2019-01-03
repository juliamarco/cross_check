module SeasonStatistics

# Helper Method
  def games_by_season(season) #tested line 235
    season = season.to_i
    games = @games_data.find_all { |game| game.season == season }
    games.map { |game| game.game_id }
  end

# Helper Method
  def game_by_type(season, type) #tested line 241
    games = games_by_season(season)
    games = @games_data.map do |game|
      if games.include?(game.game_id)
        if game.type == type
          game.game_id
        end
      end
    end.compact
  end

  def biggest_bust(season) #tested line 253
    season = season.to_i
    preseason = wins_percentage(season, "P")
    regular = wins_percentage(season, "R")
    arr = {}
    regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.max_by { |k,v| v }
    team_id_name(biggest[0])
  end

  def biggest_surprise(season) #tested line 258
    preseason = wins_percentage(season.to_i, "P")
    regular = wins_percentage(season.to_i, "R")
    arr = {}
    regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.min_by { |k,v| v }
    team_id_name(biggest[0])
  end

# Helper Method
  def away_goals_scored(games, team_id) #tested line 263
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

# Helper Method
  def home_goals_allowed(games, team_id) #tested line 281
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

  def team_games(games, team_id)
    @games_teams_stats.find_all do |game|
      binding.pry
      games.include?(game) && game.team_id == team_id
    end
  end

  def season_summary(season, team_id)
    all_preseason_games = game_by_type(season, "P")
    all_reg_season_games = game_by_type(season, "R")
    binding.pry
    team_games(all_preseason_games, team_id)
    # reg_preseason_games
  end


end
