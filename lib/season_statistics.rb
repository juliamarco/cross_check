module SeasonStatistics

  def game_by_type(season, type) #tested line 236
    games = games_by_season(season)
    games = @games_data.map do |game|
      if games.include?(game.game_id)
        if game.type == type
          game.game_id
        end
      end
    end.compact
  end

  def wins_percentage(season, type) #tested line 242
    games = game_by_type(season, type)
    hash = Hash.new(0)
    @games_teams_stats.each do |stat|
      if games.include?(stat.game_id)
        if hash.has_key?(stat.team_id)
          hash[stat.team_id].push(stat.won)
        else
          hash[stat.team_id] = [stat.won]
        end
      end
    end
    calculate_percentages(hash)
  end

  def calculate_percentages(hash) #tested line 190
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


  def games_by_season(season) #tested line 230
    games = @games_data.find_all do |game|
      game.season == season
    end
    games.map do |game|
      game.game_id
    end
  end

  def biggest_bust(season) #tested line 248
    preseason = wins_percentage(season, "P")
    regular = wins_percentage(season, "R")
    arr = {}
    regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.max_by {|k,v| v}
    team_id_name(biggest[0])
  end

  def biggest_surprise(season) #tested line 253
    preseason = wins_percentage(season, "P")
    regular = wins_percentage(season, "R")
    arr = {}
    regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.min_by {|k,v| v}
    team_id_name(biggest[0])
  end

  def team_id_name(id) #tested line 336
    team = @teams_data.find { |team| team.team_id == id }
    return team.teamName
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

  def season_summary(season, team_id) #tested line 258
    summary = {:preseason => {}, :regular_season => {}}
    summary[:preseason][:win_percentage] = wins_percentage(season, "P").find {|k,v| k == team_id}[1]
    summary[:regular_season][:win_percentage] = wins_percentage(season, "R").find {|k,v| k == team_id}[1]
    preseason_games = game_by_type(season, "P")
    p_goals_scored = away_goals_scored(preseason_games, team_id) + home_goals_scored(preseason_games, team_id)
    summary[:preseason][:goals_scored] = p_goals_scored
    p_goals_allowed = away_goals_allowed(preseason_games, team_id) + home_goals_allowed(preseason_games, team_id)
    summary[:preseason][:goals_against] = p_goals_allowed
    regular_season_games = game_by_type(season, "R")
    r_goals_scored = away_goals_scored(regular_season_games, team_id) + home_goals_scored(regular_season_games, team_id)
    summary[:regular_season][:goals_scored] = r_goals_scored
    r_goals_allowed = away_goals_allowed(regular_season_games, team_id) + home_goals_allowed(regular_season_games, team_id)
    summary[:regular_season][:goals_against] = r_goals_allowed
    return summary
  end

end
